package proiectcolectiv.g934.itemrental.page.details

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.stfalcon.frescoimageviewer.ImageViewer
import kotlinx.android.synthetic.main.fragment_details.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull

class DetailsFragment : BaseFragment<DetailsViewModel, DetailsViewModelProvider>(), DetailsAdapter.RentableItemClickedListener {

    override fun getViewModelClass() = DetailsViewModel::class.java

    private var rentalItem: RentableItemModel? = null
    private lateinit var adapter: DetailsAdapter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_details, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        rentalItem = arguments!!.getParcelable("rentableItem")
        setupFields()
        setupListeners()
        setupRecyclerView()
        setupObservers()
    }

    override fun onResume() {
        super.onResume()
        rentalItem?.let {
            viewModel.getUserRentableItems(it.ownerName)
        }
    }

    private fun setupRecyclerView() {
        adapter = DetailsAdapter(activity, this)
        detailsRecyclerView.layoutManager = LinearLayoutManager(activity, RecyclerView.HORIZONTAL, false)
        detailsRecyclerView.adapter = adapter
    }

    private fun setupFields() = rentalItem?.run {
        if (imagePath == null) {
            Glide.with(this@DetailsFragment)
                    .load(activity.getDrawable(R.mipmap.ic_logo_foreground))
                    .into(detailsImage)
            detailsImage.isClickable = false
        }
        else Glide.with(this@DetailsFragment).load(imagePath).into(detailsImage)
        itemTitle.text = title
        itemCategoryTextView.text = category
        itemPrice.text = getString(R.string.price_lei, price)
        itemDescriptionTextView.text = itemDescription
        itemStartTimeTextView.text = startDate
        itemEndTimeTextView.text = endDate
    }

    private fun setupListeners() {
        detailsBackButton.setOnClickListener {
            navController.navigateUp()
        }
        detailsImage.setOnClickListener {
            ImageViewer.Builder(activity, listOf(rentalItem?.imagePath))
                    .setFormatter { path -> "file://$path" }
                    .show()
        }
    }

    private fun setupObservers() {
        viewModel.userRentableItemsLiveData.observeNonNull(this) {
            when (it) {
                is Outcome.Progress -> if (it.loading) showLoading() else hideLoading()
                is Outcome.Success -> {
                    adapter.setItems(it.data.filter { item -> item.itemId != rentalItem!!.itemId })
                    if (adapter.itemCount == 0) {
                        showEmpty()
                    }
                    hideLoading()
                }
                is Outcome.Failure -> {
                    if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                    else showError(it.error.localizedMessage)
                }
            }
        }
    }

    private fun showLoading() {
        detailsEmptyLayout.showLoading()
        detailsRecyclerView.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        detailsEmptyLayout.hide()
        detailsRecyclerView.visibility = View.VISIBLE
    }

    private fun showError(error: String?) {
        detailsEmptyLayout.setError(error)
        detailsEmptyLayout.showError()
    }

    private fun showEmpty() {
        detailsEmptyLayout.showEmpty(getString(R.string.no_other_items))
    }

    override fun onRentableItemClicked(rentableItemModel: RentableItemModel) {
        navController.navigate(R.id.action_detailsFragment_self, Bundle().also { it.putParcelable("rentableItem", rentableItemModel) })
    }
}