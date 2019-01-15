package proiectcolectiv.g934.itemrental.data.remote.model

import com.google.gson.annotations.SerializedName

data class LocationModel(
        @SerializedName("city")
        var city: String,

        @SerializedName("street")
        var street: String,

        @SerializedName("coordX")
        var coordX: Double,

        @SerializedName("coordY")
        var coordY: Double
)