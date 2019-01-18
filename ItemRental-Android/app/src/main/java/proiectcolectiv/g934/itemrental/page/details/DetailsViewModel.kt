package proiectcolectiv.g934.itemrental.page.details

import androidx.lifecycle.MutableLiveData
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.utils.Outcome

class DetailsViewModel(private val remoteRepo: RemoteRepo) : BaseViewModel() {

    val userRentableItemsLiveData: MutableLiveData<Outcome<List<RentableItemModel>>> = MutableLiveData()

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
}