package proiectcolectiv.g934.itemrental.page.main

import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.di.scope.ActivityScope

@Module
class MainModule {

    @Provides
    @ActivityScope
    internal fun provideMainViewModelFactory(): MainViewModelFactory = MainViewModelFactory()
}