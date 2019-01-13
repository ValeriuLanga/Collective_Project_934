package proiectcolectiv.g934.itemrental.data.remote.model

import com.google.gson.annotations.SerializedName

data class UserModel(
    @SerializedName("name")
    var userName: String,

    @SerializedName("password")
    var password: String,

    @SerializedName("email")
    var email: String,

    @SerializedName("rating")
    var rating: Int,

    @SerializedName("phone")
    var phone: String,

    @SerializedName("location")
    var location: LocationModel,

    @SerializedName("error")
    var error: String?
)