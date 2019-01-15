package proiectcolectiv.g934.itemrental.page.register

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import proiectcolectiv.g934.itemrental.data.remote.repo.UserRepo

class RegisterViewModelFactory(private val userRepo: UserRepo) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = RegisterViewModel(userRepo) as T
}