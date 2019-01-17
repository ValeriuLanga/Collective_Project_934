package proiectcolectiv.g934.itemrental.page.add

import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.utils.Outcome
import java.text.SimpleDateFormat
import java.util.*

class AddViewModel(private val userPref: StringPreference,
                   private val gson: Gson) : BaseViewModel() {

    val addItemLiveData: MutableLiveData<Outcome<String>> = MutableLiveData()

    fun addItem(title: String, category: String, usageType: String, description: String, price: Int) {
        val currentTime = Calendar.getInstance().time
        val simpleDateFormat = SimpleDateFormat("MMM dd yyyy KK:mma", Locale.getDefault())
        val rentableItem = RentableItemModel(
                category = category,
                title = title,
                usageType = usageType,
                itemDescription = description,
                price = price,
                ownerName = gson.fromJson(userPref.get(), UserModel::class.java).userName,
                startDate = simpleDateFormat.format(currentTime)
        )
    }
}