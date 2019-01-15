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
        var rating: Int = 0,

        @SerializedName("phone")
        var phone: String,

        @SerializedName("location")
        var location: LocationModel
)