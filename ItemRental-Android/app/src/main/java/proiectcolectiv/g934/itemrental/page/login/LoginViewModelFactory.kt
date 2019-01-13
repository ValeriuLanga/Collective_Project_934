package proiectcolectiv.g934.itemrental.page.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import proiectcolectiv.g934.itemrental.data.remote.ApiService
import proiectcolectiv.g934.itemrental.data.remote.RemoteRepo

class LoginViewModelFactory(private val remoteRepo: RemoteRepo) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>) = LoginViewModel(remoteRepo) as T
}