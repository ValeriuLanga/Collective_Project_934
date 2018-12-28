package proiectcolectiv.g934.itemrental.page.login

import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.di.scope.ActivityScope

@Module
class LoginModule {

    @Provides
    @ActivityScope
    fun provideViewModelFactory(): LoginViewModelFactory = LoginViewModelFactory()
}