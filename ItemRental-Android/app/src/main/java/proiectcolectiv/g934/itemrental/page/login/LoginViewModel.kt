package proiectcolectiv.g934.itemrental.page.login

import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.remote.ApiService

class LoginViewModel(private val apiService: ApiService) : BaseViewModel() {

    fun makeTestCall(){
        addDisposable(apiService.getAllRentableItems()
            .subscribe())
    }
}