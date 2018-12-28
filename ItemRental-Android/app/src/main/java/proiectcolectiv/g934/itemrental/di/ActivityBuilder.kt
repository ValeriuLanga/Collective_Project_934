package proiectcolectiv.g934.itemrental.di

import dagger.Module
import dagger.android.ContributesAndroidInjector
import proiectcolectiv.g934.itemrental.di.scope.ActivityScope
import proiectcolectiv.g934.itemrental.page.login.LoginActivity
import proiectcolectiv.g934.itemrental.page.login.LoginModule

@Module
abstract class ActivityBuilder {

    @ActivityScope
    @ContributesAndroidInjector(modules = [LoginModule::class])
    abstract fun provideLoginActivity(): LoginActivity
}