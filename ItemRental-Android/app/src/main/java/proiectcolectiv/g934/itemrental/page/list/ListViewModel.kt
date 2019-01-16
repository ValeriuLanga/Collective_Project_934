package proiectcolectiv.g934.itemrental.page.list

import androidx.lifecycle.MutableLiveData
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.utils.Outcome

class ListViewModel(private val remoteRepo: RemoteRepo) : BaseViewModel() {

    val rentableItemsLiveData: MutableLiveData<Outcome<List<RentableItemModel>>> = MutableLiveData()

    fun getRentableItemsFromServer() {
        rentableItemsLiveData.value = Outcome.loading(true)
        addDisposable(
                remoteRepo.getAllRentableItems()
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(this::getItemsSuccess, this::getItemsError)
        )
    }

    private fun getItemsSuccess(itemList: List<RentableItemModel>) {
        rentableItemsLiveData.value = Outcome.success(itemList)
    }

    private fun getItemsError(throwable: Throwable) {
        rentableItemsLiveData.value = Outcome.failure(throwable)
    }
}