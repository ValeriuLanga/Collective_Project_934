package proiectcolectiv.g934.itemrental.di

import android.app.Application
import dagger.BindsInstance
import dagger.Component
import dagger.android.AndroidInjector
import dagger.android.support.AndroidSupportInjectionModule
import dagger.android.support.DaggerApplication
import proiectcolectiv.g934.itemrental.ItemRentalApplication
import proiectcolectiv.g934.itemrental.data.remote.ApiModule
import proiectcolectiv.g934.itemrental.di.scope.ApplicationScope

@ApplicationScope
@Component(modules = [AndroidSupportInjectionModule::class,
    AppModule::class,
    ActivityBuilder::class,
    ApiModule::class
])
interface AppComponent : AndroidInjector<DaggerApplication> {

    fun inject(itemRentalApplication: ItemRentalApplication)

    override fun inject(instance: DaggerApplication)

    @Component.Builder
    interface Builder {

        @BindsInstance
        fun application(application: Application): Builder

        fun build(): AppComponent
    }
}