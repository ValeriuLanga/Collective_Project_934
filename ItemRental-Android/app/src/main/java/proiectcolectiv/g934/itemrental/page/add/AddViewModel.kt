package proiectcolectiv.g934.itemrental.page.add

import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.utils.Outcome

class AddViewModel(private val userPref: StringPreference,
                   private val gson: Gson,
                   private val remoteRepo: RemoteRepo) : BaseViewModel() {

    val addItemLiveData: MutableLiveData<Outcome<String>> = MutableLiveData()

    fun addItem(title: String, category: String, description: String, price: Int, startDate: String, endDate: String, imagePath: String) {
        addItemLiveData.value = Outcome.loading(true)
        val rentableItem = RentableItemModel(
                category = category,
                title = title,
                itemDescription = description,
                price = price,
                ownerName = gson.fromJson(userPref.get(), UserModel::class.java).userName,
                startDate = startDate,
                endDate = endDate,
                imagePath = imagePath
        )
        addDisposable(
                remoteRepo.uploadRentableItem(rentableItem)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe({
                            addItemLiveData.value = Outcome.success(it)
                        }, {
                            addItemLiveData.value = Outcome.failure(it)
                        })
        )
    }
}