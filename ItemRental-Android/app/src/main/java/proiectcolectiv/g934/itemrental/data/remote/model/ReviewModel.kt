package proiectcolectiv.g934.itemrental.data.remote.model

import com.google.gson.annotations.SerializedName

data class ReviewModel(
        @SerializedName("posted_date")
        var postedDate: String? = null,

        @SerializedName("text")
        val text: String,

        @SerializedName("rating")
        val rating: Int,

        @SerializedName("owner_name")
        val ownerName: String,

        @SerializedName("rentableitem_id")
        val rentableItemId: String
)