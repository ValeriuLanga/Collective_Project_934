package proiectcolectiv.g934.itemrental.data.remote

import io.reactivex.Flowable
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.RentableItems.RENTABLEITEMS_REVIEWS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Reviews.REVIEWS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS_LOGIN
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS_RENTABLE
import proiectcolectiv.g934.itemrental.data.remote.ApiConstants.Users.USERS_REVIEWS
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.data.remote.model.ReviewModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserLoginModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.response.RentableItemsResponse
import proiectcolectiv.g934.itemrental.data.remote.response.ReviewsResponse
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path

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
}