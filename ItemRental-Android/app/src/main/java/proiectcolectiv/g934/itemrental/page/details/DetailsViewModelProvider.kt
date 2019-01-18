package proiectcolectiv.g934.itemrental.page.details

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo

class DetailsViewModelProvider(private val remoteRepo: RemoteRepo) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = DetailsViewModel(remoteRepo) as T
}