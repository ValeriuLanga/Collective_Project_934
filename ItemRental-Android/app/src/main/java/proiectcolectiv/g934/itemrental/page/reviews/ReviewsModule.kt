package proiectcolectiv.g934.itemrental.page.reviews

import com.google.gson.Gson
import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.data.local.prefs.AppPrefsConstants
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.di.scope.FragmentScope
import javax.inject.Named

@Module
class ReviewsModule {

    @Provides
    @FragmentScope
    internal fun provideViewModelFactory(remoteRepo: RemoteRepo,
                                         @Named(AppPrefsConstants.USER_PREF) userPref: StringPreference,
                                         gson: Gson): ReviewsViewModelFactory = ReviewsViewModelFactory(remoteRepo, userPref, gson)
}