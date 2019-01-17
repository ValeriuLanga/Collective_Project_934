package proiectcolectiv.g934.itemrental.page.login

import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.repo.UserRepo
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.SingleEvent

class LoginViewModel(
        private val userRepo: UserRepo,
        private val userPref: StringPreference,
        private val gson: Gson
) : BaseViewModel() {

    val loginLiveData: MutableLiveData<SingleEvent<Outcome<UserModel>>> = MutableLiveData()

    fun loginUser(username: String, password: String) {
        loginLiveData.value = SingleEvent(Outcome.loading(true))
        addDisposable(
                userRepo.loginUser(username, password)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe({
                            userPref.set(gson.toJson(it))
                            loginLiveData.value = SingleEvent(Outcome.success(it))
                        }, {
                            loginLiveData.value = SingleEvent(Outcome.failure(it))
                        })
        )
    }
}