package proiectcolectiv.g934.itemrental.page.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.google.gson.Gson
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.repo.UserRepo

class LoginViewModelFactory(
    private val userRepo: UserRepo,
    private val userPref: StringPreference,
    private val gson: Gson
) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>) = LoginViewModel(userRepo, userPref, gson) as T
}