package proiectcolectiv.g934.itemrental.data.remote.repo

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import io.reactivex.Flowable
import io.reactivex.schedulers.Schedulers
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorConverter
import proiectcolectiv.g934.itemrental.data.remote.ApiService
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import javax.inject.Inject

class RemoteRepo @Inject constructor() {

    @Inject
    lateinit var apiService: ApiService

    @Inject
    lateinit var context: Context

    fun getAllRentableItems(): Flowable<List<RentableItemModel>> = apiService.getAllRentableItems()
            .subscribeOn(Schedulers.io())
            .flatMap(ApiErrorConverter())
            .map { it -> it.rentableItems }
            .flatMapIterable { it -> it }
            .flatMap { downloadImageForItem(it) }
            .toList()
            .toFlowable()

    fun uploadRentableItem(rentableItem: RentableItemModel): Flowable<String> = apiService.postRentableItem(rentableItem)
            .subscribeOn(Schedulers.io())
            .flatMap(ApiErrorConverter())
            .flatMap { uploadImageToServer(it.itemId, rentableItem.image) }

    private fun uploadImageToServer(itemId: Int, bitmap: Bitmap?): Flowable<String> {
        if (bitmap == null)
            return Flowable.just("Image missing from local source")

        val file = File(context.cacheDir, "TempPhotoUpload")
        file.createNewFile()

        val byteArrayOutputStream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 0, byteArrayOutputStream)
        val bitmapData = byteArrayOutputStream.toByteArray()

        FileOutputStream(file).apply {
            write(bitmapData)
            flush()
            close()
        }

        val multipartBody =
                MultipartBody.Part.createFormData("pic", file.name, RequestBody.create(MediaType.parse("image/jpeg"), file))
        return apiService.postRentableItemImage(itemId, multipartBody)
                .subscribeOn(Schedulers.io())
                .flatMap(ApiErrorConverter())
    }

    private fun downloadImageForItem(rentableItem: RentableItemModel): Flowable<RentableItemModel> {
        return apiService.getRentableItemImage(rentableItem.itemId)
                .subscribeOn(Schedulers.io())
                .flatMap(ApiErrorConverter())
                .map {
                    val inputStream = it.byteStream()
                    val bitmap = BitmapFactory.decodeStream(inputStream)
                    rentableItem.image = bitmap
                    rentableItem
                }
                .onErrorReturnItem(rentableItem)
    }
}