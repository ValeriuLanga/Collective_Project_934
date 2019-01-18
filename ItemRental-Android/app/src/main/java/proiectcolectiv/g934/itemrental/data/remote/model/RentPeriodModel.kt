package proiectcolectiv.g934.itemrental.data.remote.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
data class RentPeriodModel(
        @SerializedName("start_date")
        val startDate: String,

        @SerializedName("end_date")
        val endDate: String,

        @SerializedName("user_name")
        val userName: String
) : Parcelable