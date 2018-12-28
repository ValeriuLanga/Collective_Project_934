package proiectcolectiv.g934.itemrental

import dagger.android.AndroidInjector
import dagger.android.support.DaggerApplication
import proiectcolectiv.g934.itemrental.di.DaggerAppComponent
import timber.log.Timber
import javax.inject.Inject

class ItemRentalApplication : DaggerApplication() {

    @Inject
    lateinit var timber: Timber.Tree

    override fun onCreate() {
        super.onCreate()
        Timber.plant(timber)
    }

    override fun applicationInjector(): AndroidInjector<out DaggerApplication> {
        val appComponent = DaggerAppComponent.builder().application(this).build()
        appComponent.inject(this)
        return appComponent
    }
}