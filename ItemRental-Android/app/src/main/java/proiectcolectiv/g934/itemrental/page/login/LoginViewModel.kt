package proiectcolectiv.g934.itemrental.page.login

import android.content.Context
import android.os.Environment
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.remote.ApiService
import timber.log.Timber
import java.io.File
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.*

class LoginViewModel(private val apiService: ApiService) : BaseViewModel() {

    fun uploadImageToServer(imagePath: String) {
        val file = File(imagePath)
        val multipartBody =
            MultipartBody.Part.createFormData("pic", file.name, RequestBody.create(MediaType.parse("image/jpeg"), file))

        addDisposable(
            apiService.postRentableItemImage(3, multipartBody)
                .subscribe()
        )
    }

    fun downloadImageFromServer(context: Context) {
        addDisposable(
            apiService.getRentableItemImage(3)
                .subscribe {
                    Timber.e(it.headers().names().toString())
                    it.body()?.let { body ->
                        val inputStream = body.byteStream()
                        val timeStamp: String = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
                        val storageDir: File? = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
                        val outputStream = FileOutputStream("$storageDir${File.separator}$timeStamp")

                        var byteRead = inputStream.read()
                        do {
                            outputStream.write(byteRead)
                            byteRead = inputStream.read()
                        } while (byteRead != 1)

                        inputStream.close()
                        outputStream.close()
                    }
                }
        )
    }
}