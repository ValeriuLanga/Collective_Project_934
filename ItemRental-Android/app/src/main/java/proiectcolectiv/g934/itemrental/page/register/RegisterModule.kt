package proiectcolectiv.g934.itemrental.page.register

import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.data.remote.repo.UserRepo
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope

@Module
class RegisterModule {

    @Provides
    @FragmentScope
    internal fun provideViewModelFactory(userRepo: UserRepo) = RegisterViewModelFactory(userRepo)
}