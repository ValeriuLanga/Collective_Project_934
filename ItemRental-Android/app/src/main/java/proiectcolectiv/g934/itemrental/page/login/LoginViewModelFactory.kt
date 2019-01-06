package proiectcolectiv.g934.itemrental.page.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import proiectcolectiv.g934.itemrental.data.remote.ApiService

class LoginViewModelFactory(private val apiService: ApiService) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>) = LoginViewModel(apiService) as T
}