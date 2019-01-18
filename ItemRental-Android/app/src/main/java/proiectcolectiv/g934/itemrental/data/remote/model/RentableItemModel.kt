package proiectcolectiv.g934.itemrental.data.remote.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
data class RentableItemModel(
        @SerializedName("id")
        val itemId: Int = 0,

        @SerializedName("category")
        val category: String,

        @SerializedName("receiving_details")
        val receivingDetails: String = "",

        @SerializedName("item_description")
        val itemDescription: String,

        @SerializedName("price")
        val price: Int,

        @SerializedName("owner_name")
        val ownerName: String,

        @SerializedName("title")
        val title: String,

        @SerializedName("start_date")
        val startDate: String = "",

        @SerializedName("end_date")
        val endDate: String = "",

        @Transient
        var imagePath: String? = null
) : Parcelable