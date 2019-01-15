package proiectcolectiv.g934.itemrental.data.remote.repo

import io.reactivex.Flowable
import io.reactivex.schedulers.Schedulers
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorConverter
import proiectcolectiv.g934.itemrental.data.remote.ApiService
import proiectcolectiv.g934.itemrental.data.remote.model.UserLoginModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import javax.inject.Inject

class UserRepo @Inject constructor() {

    @Inject
    lateinit var apiService: ApiService

    fun loginUser(username: String, password: String): Flowable<UserModel> =
            apiService.loginUser(UserLoginModel(username, password))
                    .subscribeOn(Schedulers.io())
                    .flatMap(ApiErrorConverter())

    fun registerUser(userModel: UserModel): Flowable<UserModel> =
            apiService.registerUser(userModel)
                    .subscribeOn(Schedulers.io())
                    .flatMap(ApiErrorConverter())
}