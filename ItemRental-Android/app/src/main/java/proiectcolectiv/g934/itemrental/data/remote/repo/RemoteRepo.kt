package proiectcolectiv.g934.itemrental.data.remote.repo

import android.graphics.BitmapFactory
import io.reactivex.Flowable
import io.reactivex.schedulers.Schedulers
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorConverter
import proiectcolectiv.g934.itemrental.data.remote.ApiService
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import java.io.File
import javax.inject.Inject

class RemoteRepo @Inject constructor() {

    @Inject
    lateinit var apiService: ApiService

    fun getAllRentableItems(): Flowable<List<RentableItemModel>> = apiService.getAllRentableItems()
            .subscribeOn(Schedulers.io())
            .flatMap(ApiErrorConverter())
            .map { it -> it.rentableItems }
            .flatMapIterable { it -> it }
            .flatMap { downloadImageForItem(it) }
            .toList()
            .toFlowable()

    fun uploadImageToServer(itemId: Int, imagePath: String): Flowable<String> {
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
                    val bitmap = BitmapFactory.decodeStream(inputStream)
                    rentableItem.image = bitmap
                    rentableItem
                }
    }
}