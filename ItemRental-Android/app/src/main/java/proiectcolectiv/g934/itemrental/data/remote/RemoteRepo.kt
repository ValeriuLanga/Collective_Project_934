package proiectcolectiv.g934.itemrental.data.remote

import android.content.Context
import android.os.Environment
import io.reactivex.Flowable
import io.reactivex.schedulers.Schedulers
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import java.io.File
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject

class RemoteRepo @Inject constructor() {

    @Inject
    lateinit var apiService: ApiService

    @Inject
    lateinit var context: Context

    fun uploadImageToServer(itemId: Int, imagePath: String): Flowable<String> {
        val file = File(imagePath)
        val multipartBody =
            MultipartBody.Part.createFormData("pic", file.name, RequestBody.create(MediaType.parse("image/jpeg"), file))
        return apiService.postRentableItemImage(itemId, multipartBody)
            .subscribeOn(Schedulers.io())
            .flatMap(ApiErrorConverter())
    }

    fun downloadImageForItem(itemId: Int): Flowable<String> {
        return apiService.getRentableItemImage(itemId)
            .subscribeOn(Schedulers.io())
            .flatMap(ApiErrorConverter())
            .map {
                val inputStream = it.byteStream()
                val timeStamp: String = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
                val storageDir: File = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES)!!
                val outputStream = FileOutputStream("$storageDir${File.separator}JPEG_${timeStamp}_.jpg")
                outputStream.write(inputStream.readBytes())
                inputStream.close()
                outputStream.close()
                storageDir.absolutePath
            }
    }
}