package proiectcolectiv.g934.itemrental.data.local.prefs

import android.content.Context
import android.content.SharedPreferences
import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.ItemRentalApplication
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.di.scope.ApplicationScope
import javax.inject.Named

@Module
class AppPrefsModule {

    @Provides
    @ApplicationScope
    fun provideSharedPreferences(application: ItemRentalApplication): SharedPreferences =
        application.getSharedPreferences(application.getString(R.string.app_name), Context.MODE_PRIVATE)

    @Provides
    @ApplicationScope
    @Named(AppPrefsConstants.USER_PREF)
    fun provideUserPreference(sharedPreferences: SharedPreferences): StringPreference =
        StringPreference(sharedPreferences, AppPrefsConstants.USER_PREF)
}