package proiectcolectiv.g934.itemrental.di

import android.app.Application
import android.content.Context
import dagger.Module
import dagger.Provides
import proiectcolectiv.g934.itemrental.ItemRentalApplication
import proiectcolectiv.g934.itemrental.di.scope.ApplicationScope
import timber.log.Timber

@Module
class AppModule {

    @Provides
    @ApplicationScope
    internal fun provideApplication(application: Application): ItemRentalApplication = application as ItemRentalApplication

    @Provides
    @ApplicationScope
    internal fun provideContext(application: Application): Context = application

    @Provides
    @ApplicationScope
    internal fun provideTimberTree(): Timber.Tree = Timber.DebugTree()
}