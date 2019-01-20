package proiectcolectiv.g934.itemrental.page.reviews

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.fragment_reviews.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.page.dialogs.ReviewDialogFragment
import proiectcolectiv.g934.itemrental.page.dialogs.ReviewDialogListener
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull

class ReviewsFragment : BaseFragment<ReviewsViewModel, ReviewsViewModelFactory>(), ReviewDialogListener {

    override fun getViewModelClass() = ReviewsViewModel::class.java

    private lateinit var adapter: ReviewsAdapter
    private var itemId = 0
    private var ownerName: String? = null
    private lateinit var reviewDialogFragment: ReviewDialogFragment

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_reviews, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        arguments?.let {
            itemId = it.getInt("rentableItemId")
            ownerName = it.getString("ownerName")
        }
        setListeners()
        setRecyclerView()
        setObservers()
        if (viewModel.getCurrentUserName() == ownerName) {
            reviewsAddButton.visibility = View.GONE
        }
    }

    private fun setListeners() {
        reviewsBackButton.setOnClickListener {
            navController.navigateUp()
        }
        reviewsAddButton.setOnClickListener {
            fragmentManager?.let { fm ->
                reviewDialogFragment = ReviewDialogFragment.createReviewDialogFragment(fm, this)
            }
        }
    }

    override fun onResume() {
        super.onResume()
        viewModel.getItemReviews(itemId)
    }

    private fun setRecyclerView() {
        adapter = ReviewsAdapter()
        reviewsRecyclerView.layoutManager = LinearLayoutManager(activity)
        reviewsRecyclerView.adapter = adapter
    }

    private fun setObservers() {
        viewModel.reviewsLiveData.observeNonNull(this) {
            when (it) {
                is Outcome.Progress -> showLoading()
                is Outcome.Success -> {
                    if (it.data.isEmpty()) showEmpty()
                    else {
                        adapter.setItems(it.data)
                        hideLoading()
                    }
                }
                is Outcome.Failure -> {
                    if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                    else showError(it.error.localizedMessage)
                }
            }
        }
        viewModel.addReviewLiveData.observeNonNull(this) {
            when (it) {
                is Outcome.Progress -> reviewDialogFragment.showLoading()
                is Outcome.Success -> {
                    reviewDialogFragment.dismiss()
                    viewModel.getItemReviews(itemId)
                }
                is Outcome.Failure -> {
                    if (it.error is ApiErrorThrowable) reviewDialogFragment.showError(it.error.errorResponse.error)
                    else reviewDialogFragment.showError(it.error.localizedMessage)
                }
            }
        }
    }

    override fun addReview(rating: Int, comment: String) {
        viewModel.addItemReview(rating, comment, itemId)
    }

    private fun showLoading() {
        reviewsEmptyLayout.showLoading()
        reviewsRecyclerView.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        reviewsEmptyLayout.hide()
        reviewsRecyclerView.visibility = View.VISIBLE
    }

    private fun showEmpty() {
        reviewsEmptyLayout.showEmpty(getString(R.string.no_reviews))
        reviewsRecyclerView.visibility = View.INVISIBLE
    }

    private fun showError(error: String?) {
        reviewsEmptyLayout.setError(error)
        reviewsEmptyLayout.showError()
    }
}