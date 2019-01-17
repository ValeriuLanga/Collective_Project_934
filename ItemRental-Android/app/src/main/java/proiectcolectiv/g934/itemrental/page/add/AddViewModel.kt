package proiectcolectiv.g934.itemrental.page.add

import android.graphics.Bitmap
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.utils.Outcome
import java.text.SimpleDateFormat
import java.util.*

class AddViewModel(private val userPref: StringPreference,
                   private val gson: Gson,
                   private val remoteRepo: RemoteRepo) : BaseViewModel() {

    val addItemLiveData: MutableLiveData<Outcome<String>> = MutableLiveData()

    fun addItem(title: String, category: String, usageType: String, description: String, price: Int, endDate: String, imageBitmap: Bitmap) {
        addItemLiveData.value = Outcome.loading(true)
        val currentTime = Calendar.getInstance().time
        val simpleDateFormat = SimpleDateFormat("MMM dd yyyy hh:mma", Locale.getDefault())
        val rentableItem = RentableItemModel(
                category = category,
                title = title,
                usageType = usageType,
                itemDescription = description,
                price = price,
                ownerName = gson.fromJson(userPref.get(), UserModel::class.java).userName,
                startDate = simpleDateFormat.format(currentTime),
                endDate = endDate,
                image = imageBitmap
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