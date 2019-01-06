package proiectcolectiv.g934.itemrental.base

import android.os.Bundle
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import dagger.android.support.DaggerAppCompatActivity
import javax.inject.Inject

abstract class BaseActivity<VM : BaseViewModel, VMF : ViewModelProvider.Factory> : DaggerAppCompatActivity() {

    @Inject
    lateinit var viewModelFactory: VMF

    protected lateinit var viewModel: VM

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel = ViewModelProviders.of(this, viewModelFactory).get(getViewModelClass())
    }

    protected abstract fun getViewModelClass(): Class<VM>
}