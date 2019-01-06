package proiectcolectiv.g934.itemrental.data.remote

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.jakewharton.retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import dagger.Module
import dagger.Provides
import io.reactivex.schedulers.Schedulers
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import proiectcolectiv.g934.itemrental.di.scope.ApplicationScope
import retrofit2.CallAdapter
import retrofit2.Converter
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Named
import javax.inject.Singleton

@Module
class ApiModule {

    companion object {
        const val GSON_IDENTIFIER = "gson"
    }

    @Provides
    @ApplicationScope
    internal fun provideHeaderInterceptor() = Interceptor { chain ->
        val original = chain.request()
        val request = original.newBuilder()
            .header("Accept", "application/json")
            .method(original.method(), original.body())
            .build()
        chain.proceed(request)
    }

    @Provides
    @ApplicationScope
    internal fun provideHttpLoggingInterceptor() = HttpLoggingInterceptor().also { it.level = HttpLoggingInterceptor.Level.BODY }

    @Provides
    @ApplicationScope
    internal fun provideOkHttpClient(interceptor: Interceptor, httpInterceptor: HttpLoggingInterceptor) = OkHttpClient.Builder()
        .addInterceptor(interceptor)
        .addInterceptor(httpInterceptor)
        .readTimeout(60, TimeUnit.SECONDS)
        .connectTimeout(60, TimeUnit.SECONDS)
        .writeTimeout(60, TimeUnit.SECONDS)
        .build()

    @Provides
    @ApplicationScope
    internal fun provideCallAdapterFactory(): CallAdapter.Factory = RxJava2CallAdapterFactory.createWithScheduler(
        Schedulers.io())

    @Provides
    @ApplicationScope
    internal fun provideGson() = GsonBuilder().create()

    @Provides
    @ApplicationScope
    @Named(GSON_IDENTIFIER)
    internal fun provideConverterFactory(gson: Gson): Converter.Factory = GsonConverterFactory.create(gson)

    @Provides
    @ApplicationScope
    internal fun provideRetrofit(okHttpClient: OkHttpClient,
                                 @Named(GSON_IDENTIFIER) gsonConverter: Converter.Factory,
                                 adapterFactory: CallAdapter.Factory): Retrofit = Retrofit.Builder()
        .baseUrl(ApiConstants.BASE_URL)
        .addCallAdapterFactory(adapterFactory)
        .addConverterFactory(gsonConverter)
        .client(okHttpClient)
        .build()

    @Provides
    @ApplicationScope
    internal fun provideApiService(retrofit: Retrofit): ApiService = retrofit.create(ApiService::class.java)
}