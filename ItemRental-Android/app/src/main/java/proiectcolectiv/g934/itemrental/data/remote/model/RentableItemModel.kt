package proiectcolectiv.g934.itemrental.data.remote.model

import com.google.gson.annotations.SerializedName

data class RentableItemModel(
    @SerializedName("id")
    var itemId: Int = 0,

    @SerializedName("category")
    var category: String,

    @SerializedName("usage_type")
    var usageType: String,

    @SerializedName("receiving_details")
    var receivingDetails: String,

    @SerializedName("item_description")
    var itemDescription: String,

    @SerializedName("owner_name")
    var ownerName: String,

    @SerializedName("start_date")
    var startDate: String,

    @SerializedName("end_date")
    var endDate: String,

    var imagePath: String
)