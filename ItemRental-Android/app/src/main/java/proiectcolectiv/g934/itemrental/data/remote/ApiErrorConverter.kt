package proiectcolectiv.g934.itemrental.data.remote

import com.google.gson.Gson
import io.reactivex.Flowable
import io.reactivex.functions.Function
import org.reactivestreams.Publisher
import proiectcolectiv.g934.itemrental.data.remote.response.BaseErrorResponse
import retrofit2.Response

class ApiErrorConverter<T> : Function<Response<T>, Publisher<T>> {

    val gson by lazy {
        Gson()
    }

    override fun apply(apiResponse: Response<T>): Flowable<T>? {
        val responseCode = apiResponse.code()
        if (responseCode == 200 || responseCode == 201) {
            apiResponse.body()?.let {
                return Flowable.just(it)
            }
        }
        val errorMessage = apiResponse.message()

        if (responseCode in 400..499) {
            val baseErrorResponse = gson.fromJson(apiResponse.errorBody()?.string(), BaseErrorResponse::class.java)
            return Flowable.error(ApiErrorThrowable(errorMessage, baseErrorResponse))

        }
        return Flowable.error(ApiErrorThrowable(errorMessage, BaseErrorResponse(errorMessage)))
    }
}

class ApiErrorThrowable(override val message: String, val errorResponse: BaseErrorResponse) : Throwable(message)