package proiectcolectiv.g934.itemrental.page.add

import com.google.gson.Gson
import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.data.local.prefs.AppPrefsConstants
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope
import javax.inject.Named

@Module
class AddModule {

    @Provides
    @FragmentScope
    internal fun provideViewModelProvider(@Named(AppPrefsConstants.USER_PREF) userPref: StringPreference,
                                          gson: Gson): AddViewModelProvider
            = AddViewModelProvider(userPref, gson)
}