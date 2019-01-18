package proiectcolectiv.g934.itemrental.page.list

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.StaggeredGridLayoutManager
import kotlinx.android.synthetic.main.fragment_list.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.local.prefs.AppPrefsConstants
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel
import proiectcolectiv.g934.itemrental.page.dialogs.LogoutDialogFragment
import proiectcolectiv.g934.itemrental.page.dialogs.LogoutDialogListener
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull
import javax.inject.Inject
import javax.inject.Named

class ListFragment : BaseFragment<ListViewModel, ListViewModelFactory>(), LogoutDialogListener, ListAdapter.RentableItemClickedListener {

    override fun getViewModelClass() = ListViewModel::class.java

    @field:[Inject Named(AppPrefsConstants.USER_PREF)]
    lateinit var userPref: StringPreference

    private lateinit var adapter: ListAdapter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupRecyclerView()
        setupListeners()
        setupObservers()
    }

    override fun onResume() {
        super.onResume()
        viewModel.getRentableItemsFromServer()
    }

    private fun setupRecyclerView() {
        adapter = ListAdapter(this)
        listRecyclerView.layoutManager = StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL)
        listRecyclerView.adapter = adapter
    }

    private fun setupListeners() {
        listLogoutButton.setOnClickListener {
            fragmentManager?.let { fm ->
                LogoutDialogFragment.createLogoutDialogFragment(fm, this)
            }
        }
        listSwipeRefreshLayout.setOnRefreshListener {
            viewModel.getRentableItemsFromServer()
        }
        listEmptyLayout.setRetryClickListener(View.OnClickListener {
            viewModel.getRentableItemsFromServer()
        })
        listAddButton.setOnClickListener {
            navController.navigate(R.id.action_listFragment_to_addFragment)
        }
    }

    override fun onRentableItemClicked(rentableItemModel: RentableItemModel) {
        navController.navigate(R.id.action_listFragment_to_detailsFragment, Bundle().also { it.putParcelable("rentableItem", rentableItemModel) })
    }

    override fun logoutConfirmed() {
        if (::userPref.isInitialized) {
            userPref.delete()
            navController.navigate(R.id.action_listFragment_to_splashFragment)
        }
    }

    private fun setupObservers() {
        viewModel.rentableItemsLiveData.observeNonNull(this) {
            when (it) {
                is Outcome.Progress -> if (it.loading) showLoading() else hideLoading()
                is Outcome.Success -> {
                    adapter.setItems(it.data)
                    hideLoading()
                    listSwipeRefreshLayout.isRefreshing = false
                }
                is Outcome.Failure -> {
                    if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                    else showError(it.error.localizedMessage)
                    listSwipeRefreshLayout.isRefreshing = false
                }
            }
        }
    }

    private fun showLoading() {
        listEmptyLayout.showLoading()
        listSwipeRefreshLayout.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        listEmptyLayout.hide()
        listSwipeRefreshLayout.visibility = View.VISIBLE
    }

    private fun showError(error: String?) {
        listEmptyLayout.setError(error)
        listEmptyLayout.showError()
    }
}