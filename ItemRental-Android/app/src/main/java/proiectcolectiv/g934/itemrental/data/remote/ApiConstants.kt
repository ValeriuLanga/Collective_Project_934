package proiectcolectiv.g934.itemrental.data.remote

object ApiConstants {

    const val BASE_URL = "http://192.168.43.246:5000/api/v1/"

    object Users {
        const val USERS = "users/"
        const val USERS_LOGIN = "users/login"
        const val USERS_REVIEWS = "users/reviews"
        const val USERS_RENTABLE = "users/rentableitems"
    }

    object Reviews {
        const val REVIEWS = "reviews"
    }

    object RentableItems {
        const val RENTABLEITEMS = "rentableitems/"
        const val RENTABLEITEMS_REVIEWS = "rentableitems/reviews"
        const val RENTABLEITEMS_UPLOADIMAGE = "rentableitems/uploadimage"
        const val RENTABLEITEMS_DOWNLOADIMAGE = "rentableitems/downloadimage"
    }
}