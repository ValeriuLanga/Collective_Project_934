package proiectcolectiv.g934.itemrental.data.remote.model

import com.google.gson.annotations.SerializedName

data class UserLoginModel(
    @SerializedName("name")
    val userName: String,

    @SerializedName("password")
    val password: String
)