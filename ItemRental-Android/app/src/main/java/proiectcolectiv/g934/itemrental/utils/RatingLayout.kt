package proiectcolectiv.g934.itemrental.utils

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.appcompat.widget.AppCompatImageView
import androidx.constraintlayout.widget.ConstraintLayout
import kotlinx.android.synthetic.main.custom_review_layout.view.*
import proiectcolectiv.g934.itemrental.R

class RatingLayout @JvmOverloads constructor(
        context: Context,
        attrs: AttributeSet? = null,
        defStyleRes: Int = 0
) : ConstraintLayout(context, attrs, defStyleRes) {

    var rating: Int = 0
    private val stars: List<AppCompatImageView>

    init {
        LayoutInflater.from(context).inflate(R.layout.custom_review_layout, this, true)
        stars = listOf(customStar1, customStar2, customStar3, customStar4, customStar5)
        customStar1.setOnClickListener {
            fillRating(1)
        }
        customStar2.setOnClickListener {
            fillRating(2)
        }
        customStar3.setOnClickListener {
            fillRating(3)
        }
        customStar4.setOnClickListener {
            fillRating(4)
        }
        customStar5.setOnClickListener {
            fillRating(5)
        }
    }

    private fun fillRating(rating: Int) {
        for (index in 0 until 5) {
            if (index < rating) {
                stars[index].setImageDrawable(context.getDrawable(R.drawable.ic_star))
            } else {
                stars[index].setImageDrawable(context.getDrawable(R.drawable.ic_star_hollow))
            }
        }
        this.rating = rating
    }

}