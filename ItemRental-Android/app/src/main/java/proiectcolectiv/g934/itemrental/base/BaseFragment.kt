package proiectcolectiv.g934.itemrental.base

import android.content.Context
import android.os.Bundle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import dagger.android.support.DaggerFragment
import proiectcolectiv.g934.itemrental.page.main.MainActivity
import javax.inject.Inject

abstract class BaseFragment<VM : BaseViewModel, VMF : ViewModelProvider.Factory> : DaggerFragment() {

    @Inject
    lateinit var viewModelFactory: VMF

    protected lateinit var viewModel: VM

    @Inject
    lateinit var activity: MainActivity

    lateinit var navController: NavController

    override fun onAttach(context: Context?) {
        super.onAttach(context)
        viewModel = ViewModelProviders.of(this, viewModelFactory).get(getViewModelClass())
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        navController = NavHostFragment.findNavController(this)
    }

    protected abstract fun getViewModelClass(): Class<VM>
}