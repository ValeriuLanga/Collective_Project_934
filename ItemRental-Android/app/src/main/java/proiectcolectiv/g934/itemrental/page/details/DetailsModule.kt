package proiectcolectiv.g934.itemrental.page.details

import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope

@Module
class DetailsModule {

    @Provides
    @FragmentScope
    internal fun provideViewModelProvider(remoteRepo: RemoteRepo): DetailsViewModelProvider = DetailsViewModelProvider(remoteRepo)
}