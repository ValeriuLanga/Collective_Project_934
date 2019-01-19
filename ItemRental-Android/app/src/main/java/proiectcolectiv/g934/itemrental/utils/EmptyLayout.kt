package proiectcolectiv.g934.itemrental.utils

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import kotlinx.android.synthetic.main.empty_layout.view.*
import proiectcolectiv.g934.itemrental.R

class EmptyLayout @JvmOverloads constructor(
        context: Context,
        attrs: AttributeSet? = null,
        defStyleRes: Int = 0
) : FrameLayout(context, attrs, defStyleRes) {

    init {
        LayoutInflater.from(context).inflate(R.layout.empty_layout, this, true)
    }

    fun showLoading() {
        visibility = View.VISIBLE
        emptyLayoutProgressBar.visibility = View.VISIBLE
        emptyLayoutTryAgainLayout.visibility = View.GONE
        emptyLayoutEmptyTextView.visibility = View.GONE
    }

    fun showEmpty(emptyText: String) {
        emptyLayoutProgressBar.visibility = View.GONE
        emptyLayoutEmptyTextView.text = emptyText
        emptyLayoutEmptyTextView.visibility = View.VISIBLE
    }

    fun showError() {
        emptyLayoutProgressBar.visibility = View.GONE
        emptyLayoutTryAgainLayout.visibility = View.VISIBLE
        emptyLayoutEmptyTextView.visibility = View.GONE
    }

    fun hide() {
        visibility = View.GONE
    }

    fun setError(error: String?) {
        emptyLayoutErrorTextView.text = error
    }

    fun isErrorVisible() =
            !emptyLayoutEmptyTextView.text.isNullOrEmpty() && emptyLayoutErrorTextView.visibility == View.VISIBLE

    fun setRetryClickListener(retryClickListener: View.OnClickListener) =
            emptyLayoutTryAgainButton.setOnClickListener(retryClickListener)
}