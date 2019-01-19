package proiectcolectiv.g934.itemrental.page.reviews

import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import io.reactivex.android.schedulers.AndroidSchedulers
import proiectcolectiv.g934.itemrental.base.BaseViewModel
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.model.ReviewModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.data.remote.repo.RemoteRepo
import proiectcolectiv.g934.itemrental.utils.Outcome

class ReviewsViewModel(private val remoteRepo: RemoteRepo,
                       private val userPref: StringPreference,
                       private val gson: Gson) : BaseViewModel() {

    val reviewsLiveData: MutableLiveData<Outcome<List<ReviewModel>>> = MutableLiveData()

    fun getCurrentUserName() = gson.fromJson(userPref.get(), UserModel::class.java).userName

    fun getItemReviews(itemId: Int) {
        reviewsLiveData.value = Outcome.loading(true)
        addDisposable(
                remoteRepo.getItemReviews(itemId)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe({
                            reviewsLiveData.value = Outcome.success(it)
                        }, {
                            reviewsLiveData.value = Outcome.failure(it)
                        })
        )
    }
}