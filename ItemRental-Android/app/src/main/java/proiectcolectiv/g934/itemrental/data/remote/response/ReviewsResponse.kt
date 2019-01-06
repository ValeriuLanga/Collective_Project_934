package proiectcolectiv.g934.itemrental.data.remote.response

import com.google.gson.annotations.SerializedName
import proiectcolectiv.g934.itemrental.data.remote.model.ReviewModel

class ReviewsResponse {

    @SerializedName("reviewitems")
    lateinit var reviewItems: List<ReviewModel>
}