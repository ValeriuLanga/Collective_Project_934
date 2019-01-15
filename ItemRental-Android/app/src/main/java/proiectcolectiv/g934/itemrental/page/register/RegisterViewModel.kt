package proiectcolectiv.g934.itemrental.page.register

import androidx.lifecycle.MutableLiveData
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.repo.UserRepo
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.SingleEvent

class RegisterViewModel(private val userRepo: UserRepo) : BaseViewModel() {

    val registerLiveData: MutableLiveData<SingleEvent<Outcome<UserModel>>> = MutableLiveData()

    fun registerUser(userModel: UserModel) {
        registerLiveData.value = SingleEvent(Outcome.loading(true))
        addDisposable(
                userRepo.registerUser(userModel)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(this::registerUserSuccess, this::registerUserError)
        )
    }

    private fun registerUserSuccess(userModel: UserModel) {
        registerLiveData.value = SingleEvent(Outcome.success(userModel))
    }

    private fun registerUserError(throwable: Throwable) {
        registerLiveData.value = SingleEvent(Outcome.failure(throwable))
    }
}