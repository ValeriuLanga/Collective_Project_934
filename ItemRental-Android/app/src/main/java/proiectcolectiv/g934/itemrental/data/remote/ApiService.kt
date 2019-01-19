package proiectcolectiv.g934.itemrental.data.remote

import io.reactivex.Flowable
import okhttp3.MultipartBody
import okhttp3.ResponseBody
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS_DOWNLOADIMAGE
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS_RENT
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS_REVIEWS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS_UPLOADIMAGE
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Reviews.REVIEWS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS_LOGIN
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS_RENTABLE
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS_REVIEWS
import proiectcolectiv.g934.itemrental.data.remote.model.*
import proiectcolectiv.g934.itemrental.data.remote.response.RentableItemsResponse
import proiectcolectiv.g934.itemrental.data.remote.response.ReviewsResponse
import retrofit2.Response
import retrofit2.http.*

interface ApiService {

    @GET(RENTABLEITEMS)
    fun getAllRentableItems(): Flowable<Response<RentableItemsResponse>>

    @GET("$RENTABLEITEMS_REVIEWS/{rentableitem_id}")
    fun getRentableItemReviews(@Path("rentableitem_id") itemId: Int): Flowable<Response<ReviewsResponse>>

    @GET("$USERS_REVIEWS/{user_name}")
    fun getUserReviews(@Path("user_name") userName: String): Flowable<Response<ReviewsResponse>>

    @GET("$USERS_RENTABLE/{user_name}")
    fun getUserRentableItems(@Path("user_name") userName: String): Flowable<Response<RentableItemsResponse>>

    @POST(RENTABLEITEMS)
    fun postRentableItem(@Body rentableItemModel: RentableItemModel): Flowable<Response<RentableItemModel>>

    @POST(REVIEWS)
    fun postReview(@Body reviewModel: ReviewModel): Flowable<Response<ReviewModel>>

    @POST(USERS_LOGIN)
    fun loginUser(@Body userLoginModel: UserLoginModel): Flowable<Response<UserModel>>

    @POST(USERS)
    fun registerUser(@Body userModel: UserModel): Flowable<Response<UserModel>>

    @Multipart
    @POST("$RENTABLEITEMS_UPLOADIMAGE/{rentableitem_id}")
    fun postRentableItemImage(
        @Path("rentableitem_id") itemId: Int,
        @Part imageMultipart: MultipartBody.Part
    ): Flowable<Response<String>>

    @Streaming
    @GET("$RENTABLEITEMS_DOWNLOADIMAGE/{rentableitem_id}")
    fun getRentableItemImage(@Path("rentableitem_id") itemId: Int): Flowable<Response<ResponseBody>>

    @PUT("$RENTABLEITEMS_RENT/{rentableitem_id}")
    fun postRentItem(
        @Path("rentableitem_id") itemId: Int,
        @Body rentPeriodModel: RentPeriodModel
    ): Flowable<Response<String>>
}