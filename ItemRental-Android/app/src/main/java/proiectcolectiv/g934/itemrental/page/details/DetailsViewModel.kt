package proiectcolectiv.g934.itemrental.page.details

import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.model.RentPeriodModel
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.utils.Outcome

class DetailsViewModel(private val remoteRepo: RemoteRepo,
                       private val userPref: StringPreference,
                       private val gson: Gson) : BaseViewModel() {

    val userRentableItemsLiveData: MutableLiveData<Outcome<List<RentableItemModel>>> = MutableLiveData()
    val rentItemLiveData: MutableLiveData<Outcome<String>> = MutableLiveData()

    fun getLoggedUserName() = gson.fromJson(userPref.get(), UserModel::class.java).userName

    fun getUserRentableItems(userName: String) {
        userRentableItemsLiveData.value = Outcome.loading(true)
        addDisposable(
                remoteRepo.getUserRentableItems(userName)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe({
                            userRentableItemsLiveData.value = Outcome.success(it)
                        }, {
                            userRentableItemsLiveData.value = Outcome.failure(it)
                        })
        )
    }

    fun rentItem(startDate: String, endDate: String, itemId: Int) {
        rentItemLiveData.value = Outcome.loading(true)
        val rentModel = RentPeriodModel(startDate, endDate, getLoggedUserName())
        addDisposable(
                remoteRepo.rentItem(rentModel, itemId)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe({
                            rentItemLiveData.value = Outcome.success(it)
                        }, {
                            rentItemLiveData.value = Outcome.failure(it)
                        })
        )
    }
}