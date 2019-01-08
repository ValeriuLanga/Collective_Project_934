package proiectcolectiv.g934.itemrental.data.remote.response

import com.google.gson.annotations.SerializedName

class BaseErrorResponse(
    @SerializedName("code")
    val code: ResponseCode,

    @SerializedName("message")
    val message: String
)