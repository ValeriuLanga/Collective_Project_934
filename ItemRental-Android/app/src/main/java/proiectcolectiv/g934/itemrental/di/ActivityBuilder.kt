package proiectcolectiv.g934.itemrental.di

import dagger.Module
import dagger.android.ContributesAndroidInjector
import proiectcolectiv.g934.itemrental.di.scope.ActivityScope
import proiectcolectiv.g934.itemrental.page.main.MainActivity
import proiectcolectiv.g934.itemrental.page.main.MainFragmentProvider
import proiectcolectiv.g934.itemrental.page.main.MainModule

@Module
abstract class ActivityBuilder {

    @ActivityScope
    @ContributesAndroidInjector(modules = [MainModule::class, MainFragmentProvider::class])
    abstract fun provideMainActivity(): MainActivity
}