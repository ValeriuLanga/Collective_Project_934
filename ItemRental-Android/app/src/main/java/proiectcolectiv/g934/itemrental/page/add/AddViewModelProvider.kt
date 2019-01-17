package proiectcolectiv.g934.itemrental.page.add

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.google.gson.Gson
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo

class AddViewModelProvider(private val userPref: StringPreference,
                           private val gson: Gson,
                           private val remoteRepo: RemoteRepo) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = AddViewModel(userPref, gson, remoteRepo) as T
}