package proiectcolectiv.g934.itemrental.page.add

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.google.gson.Gson
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference

class AddViewModelProvider(private val userPref: StringPreference,
                           private val gson: Gson) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = AddViewModel(userPref, gson) as T
}