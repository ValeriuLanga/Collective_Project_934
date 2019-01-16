package proiectcolectiv.g934.itemrental.page.list

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo

class ListViewModelFactory(private val remoteRepo: RemoteRepo) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = ListViewModel(remoteRepo) as T
}