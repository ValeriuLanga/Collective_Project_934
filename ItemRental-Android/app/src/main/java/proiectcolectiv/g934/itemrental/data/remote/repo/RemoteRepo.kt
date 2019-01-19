package proiectcolectiv.g934.itemrental.data.remote.repo

import android.content.Context
import android.os.Environment
import com.bumptech.glide.Glide
import io.reactivex.Flowable
import io.reactivex.schedulers.Schedulers
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorConverter
import proiectcolectiv.g934.itemrental.data.remote.ApiService
import proiectcolectiv.g934.itemrental.data.remote.model.RentPeriodModel
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.model.ReviewModel
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
            .flatMapIterable { it ->
                val picturesDirectory = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
                picturesDirectory?.let { file ->
                    val files = file.listFiles()
                    for (f in files) {
                        f.delete()
                    }
                }
                Glide.get(context).clearDiskCache()
                it
            }
            .flatMap {
                downloadImageForItem(it)
            }
            .toList()
            .toFlowable()

    fun uploadRentableItem(rentableItem: RentableItemModel): Flowable<String> =
            apiService.postRentableItem(rentableItem)
                    .subscribeOn(Schedulers.io())
                    .flatMap(ApiErrorConverter())
                    .flatMap { uploadImageToServer(it.itemId, rentableItem.imagePath) }

    private fun uploadImageToServer(itemId: Int, imagePath: String?): Flowable<String> {
        if (imagePath == null)
            return Flowable.just("Image missing from local source")
        val file = File(imagePath)
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
                    val filePath =
                            "${context.getExternalFilesDir(Environment.DIRECTORY_PICTURES)}/${rentableItem.title}_${rentableItem.itemId}_.jpg"
                    val file = File(filePath)
                    val fileOutputStream = FileOutputStream(file)
                    fileOutputStream.write(inputStream.readBytes())
                    fileOutputStream.close()
                    rentableItem.imagePath = file.absolutePath
                    rentableItem
                }
                .onErrorReturnItem(rentableItem)
    }

    fun getUserRentableItems(userName: String): Flowable<List<RentableItemModel>> =
            apiService.getUserRentableItems(userName)
                    .subscribeOn(Schedulers.io())
                    .flatMap(ApiErrorConverter())
                    .map { it -> it.rentableItems }
                    .flatMapIterable { it -> it }
                    .flatMap { downloadImageForItem(it) }
                    .toList()
                    .toFlowable()

    fun rentItem(rentPeriod: RentPeriodModel, rentableItemId: Int): Flowable<String> =
            apiService.postRentItem(rentableItemId, rentPeriod)
                    .subscribeOn(Schedulers.io())
                    .flatMap(ApiErrorConverter())

    fun getItemReviews(itemId: Int): Flowable<List<ReviewModel>> =
            apiService.getRentableItemReviews(itemId)
                    .subscribeOn(Schedulers.io())
                    .flatMap(ApiErrorConverter())
                    .map { it -> it.reviewItems }
}