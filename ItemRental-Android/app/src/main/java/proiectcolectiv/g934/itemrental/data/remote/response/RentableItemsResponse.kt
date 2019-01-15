package proiectcolectiv.g934.itemrental.data.remote.response

import com.google.gson.annotations.SerializedName
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel

class RentableItemsResponse {

    @SerializedName("rentableitems")
    lateinit var rentableItems: List<RentableItemModel>
}