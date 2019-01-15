package proiectcolectiv.g934.itemrental.page.login

import com.google.gson.Gson
import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.data.local.prefs.AppPrefsConstants
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.repo.UserRepo
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope
import javax.inject.Named

@Module
class LoginModule {

    @Provides
    @FragmentScope
    fun provideViewModelFactory(
        userRepo: UserRepo,
        @Named(AppPrefsConstants.USER_PREF) userPref: StringPreference,
        gson: Gson
    ) = LoginViewModelFactory(userRepo, userPref, gson)
}