package proiectcolectiv.g934.itemrental.page.list

import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope

@Module
class ListModule {

    @Provides
    @FragmentScope
    internal fun provideViewModelFactory(remoteRepo: RemoteRepo) = ListViewModelFactory(remoteRepo)
}