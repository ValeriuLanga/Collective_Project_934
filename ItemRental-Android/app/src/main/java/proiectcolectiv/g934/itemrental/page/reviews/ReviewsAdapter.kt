package proiectcolectiv.g934.itemrental.page.reviews

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.extensions.LayoutContainer
import kotlinx.android.synthetic.main.item_review.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.data.remote.model.ReviewModel

class ReviewsAdapter : RecyclerView.Adapter<ReviewsAdapter.ReviewViewHolder>() {

    private var reviewsList: List<ReviewModel> = listOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ReviewViewHolder =
            ReviewViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_review, parent, false))

    override fun getItemCount() = reviewsList.size

    override fun onBindViewHolder(holder: ReviewViewHolder, position: Int) = holder.bind(reviewsList[position])

    fun setItems(newList: List<ReviewModel>) {
        reviewsList = newList
        notifyDataSetChanged()
    }

    inner class ReviewViewHolder(override val containerView: View) : RecyclerView.ViewHolder(containerView),
            LayoutContainer {

        fun bind(reviewItem: ReviewModel) = with(reviewItem) {
            reviewOwnerName.text = ownerName
            reviewRatingTextView.text = rating.toString()
            reviewTextTextView.text = text
            reviewPostedTimeTextView.text = postedDate
        }
    }
}