package proiectcolectiv.g934.itemrental.page.dialogs

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import kotlinx.android.synthetic.main.dialog_review.*
import proiectcolectiv.g934.itemrental.R

class ReviewDialogFragment : DialogFragment() {

    companion object {
        private const val REVIEW_DIALOG = "review_dialog"
        private lateinit var reviewDialogListener: ReviewDialogListener
        fun createReviewDialogFragment(fm: FragmentManager, reviewListener: ReviewDialogListener): ReviewDialogFragment {
            this.reviewDialogListener = reviewListener
            return ReviewDialogFragment().apply {
                show(fm, REVIEW_DIALOG)
            }
        }
    }

    private lateinit var reviewDialog: Dialog

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        context?.let { it ->
            reviewDialog = Dialog(it)
            reviewDialog.setContentView(View.inflate(it, R.layout.dialog_review, null))
        }
        return reviewDialog
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.dialog_review, container, false)
        reviewDialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        dialogReviewAdd.setOnClickListener {
            reviewDialogListener.addReview(
                    dialogReviewRating.rating,
                    dialogReviewEditText.text.toString()
            )
        }
        dialogReviewEmptyLayout.setRetryClickListener(View.OnClickListener {
            reviewDialogListener.addReview(
                    dialogReviewRating.rating,
                    dialogReviewEditText.text.toString()
            )
        })
    }

    fun showLoading() {
        dialogReviewEmptyLayout.showLoading()
        dialogReviewAdd.visibility = View.INVISIBLE
    }

    fun showError(error: String?) {
        dialogReviewEmptyLayout.setError(error)
        dialogReviewEmptyLayout.showError()
    }
}

interface ReviewDialogListener {

    fun addReview(rating: Int, comment: String)
}