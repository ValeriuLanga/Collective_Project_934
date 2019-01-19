package proiectcolectiv.g934.itemrental.page.reviews

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.google.gson.Gson
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo

class ReviewsViewModelFactory(private val remoteRepo: RemoteRepo,
                              private val userPref: StringPreference,
                              private val gson: Gson) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>) = ReviewsViewModel(remoteRepo, userPref, gson) as T
}