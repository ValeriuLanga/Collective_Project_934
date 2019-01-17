package proiectcolectiv.g934.itemrental.page.main

import dagger.Module
import dagger.android.ContributesAndroidInjector
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope
import proiectcolectiv.g934.itemrental.page.add.AddFragment
import proiectcolectiv.g934.itemrental.page.add.AddModule
import proiectcolectiv.g934.itemrental.page.list.ListFragment
import proiectcolectiv.g934.itemrental.page.list.ListModule
import proiectcolectiv.g934.itemrental.page.login.LoginFragment
import proiectcolectiv.g934.itemrental.page.login.LoginModule
import proiectcolectiv.g934.itemrental.page.register.RegisterFragment
import proiectcolectiv.g934.itemrental.page.register.RegisterModule
import proiectcolectiv.g934.itemrental.page.splash.SplashFragment

@Module
abstract class MainFragmentProvider {

    @FragmentScope
    @ContributesAndroidInjector()
    abstract fun provideSplashFragment(): SplashFragment

    @FragmentScope
    @ContributesAndroidInjector(modules = [LoginModule::class])
    abstract fun provideLoginFragment(): LoginFragment

    @FragmentScope
    @ContributesAndroidInjector(modules = [RegisterModule::class])
    abstract fun provideRegisterFragment(): RegisterFragment

    @FragmentScope
    @ContributesAndroidInjector(modules = [ListModule::class])
    abstract fun provideListFragment(): ListFragment

    @FragmentScope
    @ContributesAndroidInjector(modules = [AddModule::class])
    abstract fun provideAddFragment(): AddFragment
}