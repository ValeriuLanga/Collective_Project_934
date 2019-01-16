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
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull
import javax.inject.Inject
import javax.inject.Named

class ListFragment : BaseFragment<ListViewModel, ListViewModelFactory>() {

    override fun getViewModelClass() = ListViewModel::class.java

    @field:[Inject Named(AppPrefsConstants.USER_PREF)]
    lateinit var userPref: StringPreference

    lateinit var adapter: ListAdapter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupRecyclerView()
        setupListeners()
        setupObservers()
        viewModel.getRentableItemsFromServer()
    }

    private fun setupRecyclerView() {
        adapter = ListAdapter(activity)
        listRecyclerView.layoutManager = StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL)
        listRecyclerView.adapter = adapter
    }

    private fun setupListeners() {
        listLogoutButton.setOnClickListener {
            if (::userPref.isInitialized) {
                userPref.delete()
                navController.navigate(R.id.action_listFragment_to_splashFragment)
            }
        }
        listSwipeRefreshLayout.setOnRefreshListener {
            viewModel.getRentableItemsFromServer()
        }
        listEmptyLayout.setRetryClickListener(View.OnClickListener {
            viewModel.getRentableItemsFromServer()
        })
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