package proiectcolectiv.g934.itemrental.page.login

import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.remote.RemoteRepo
import timber.log.Timber

class LoginViewModel(private val remoteRepo: RemoteRepo) : BaseViewModel() {

    fun uploadImageToServer(imagePath: String) {
        addDisposable(
            remoteRepo.uploadImageToServer(2, imagePath)
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe {
                    Timber.e(it)
                }
        )
    }

    fun downloadImageFromServer() {
        addDisposable(
            remoteRepo.downloadImageForItem(2)
                .observeOn(Schedulers.io())
                .subscribe {
                    Timber.e("file saved as $it")
                }
        )
    }
}