package proiectcolectiv.g934.itemrental.data.remote.model

import com.google.gson.annotations.SerializedName

data class ReviewModel(
    @SerializedName("posted_date")
    var postedDate: String? = null,

    @SerializedName("text")
    var text: String,

    @SerializedName("rating")
    var rating: Int,

    @SerializedName("owner_name")
    var ownerName: String,

    @SerializedName("rentableitem_id")
    var rentableItemId: Int
)