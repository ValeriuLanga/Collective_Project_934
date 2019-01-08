package proiectcolectiv.g934.itemrental.data.remote

import com.google.gson.Gson
import com.google.gson.JsonSyntaxException
import io.reactivex.Flowable
import io.reactivex.functions.Function
import org.reactivestreams.Publisher
import proiectcolectiv.g934.itemrental.data.remote.response.BaseErrorResponse
import retrofit2.Response
import java.io.IOException

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

        if (apiResponse.errorBody() == null) {
            return Flowable.error(ApiErrorThrowable(errorMessage))
        }

        if (responseCode in 400..499) {
            val baseErrorResponse: BaseErrorResponse
            try {
                baseErrorResponse = gson.fromJson(apiResponse.raw().toString(), BaseErrorResponse::class.java)
            } catch (jsonSyntaxException: JsonSyntaxException) {
                return Flowable.error(ApiErrorThrowable(errorMessage))
            } catch (jsonSyntaxException: IOException) {
                return Flowable.error(ApiErrorThrowable(errorMessage))
            }
            return Flowable.error(ApiErrorThrowable(baseErrorResponse.message))
        }
        return Flowable.error(ApiErrorThrowable(errorMessage))
    }
}

class ApiErrorThrowable(override val message: String)
    : Throwable(message)