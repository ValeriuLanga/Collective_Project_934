package proiectcolectiv.g934.itemrental.page.login

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.view.ViewCompat
import androidx.navigation.fragment.FragmentNavigatorExtras
import androidx.transition.TransitionInflater
import kotlinx.android.synthetic.main.fragment_login.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.utils.EmptyTextChangedListener
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull
import proiectcolectiv.g934.itemrental.utils.showToast

class LoginFragment : BaseFragment<LoginViewModel, LoginViewModelFactory>() {

    override fun getViewModelClass() = LoginViewModel::class.java

//    private val REQUEST_IMAGE_CAPTURE = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        TransitionInflater.from(activity).inflateTransition(android.R.transition.move).apply {
            duration = 300
            this@LoginFragment.sharedElementEnterTransition = this
            this@LoginFragment.sharedElementReturnTransition = this
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_login, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupListeners()
        setupObservers()
    }

    private fun setupListeners() {
        usernameEditText.addTextChangedListener(EmptyTextChangedListener(usernameInput))
        passwordEditText.addTextChangedListener(EmptyTextChangedListener(passwordInput))
        logInButton.setOnClickListener {
            if (!usernameEditText.text.isNullOrEmpty() && !passwordEditText.text.isNullOrEmpty()) {
                viewModel.loginUser(usernameEditText.text!!.toString(), passwordEditText.text!!.toString())
            } else {
                activity.showToast(getString(R.string.fields_cannot_be_empty))
            }
        }
        loginEmptyLayout.setRetryClickListener(View.OnClickListener {
            viewModel.loginUser(usernameEditText.text!!.toString(), passwordEditText.text!!.toString())
        })
        registerButton.setOnClickListener {
            val extras = FragmentNavigatorExtras(splashImage to ViewCompat.getTransitionName(splashImage)!!)
            navController.navigate(R.id.action_loginFragment_to_registerFragment, null, null, extras)
        }
    }

    private fun setupObservers() {
        viewModel.loginLiveData.observeNonNull(this) { singleEvent ->
            singleEvent.getContentIfNotHandled()?.let {
                when (it) {
                    is Outcome.Progress -> if (it.loading) showLoading() else hideLoading()
                    is Outcome.Success -> navController.navigate(R.id.action_loginFragment_to_listFragment)
                    is Outcome.Failure -> {
                        if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                        else showError(it.error.localizedMessage)
                    }
                }
            }
        }
    }

    private fun showLoading() {
        loginEmptyLayout.showLoading()
        logInButton.visibility = View.INVISIBLE
        registerLayout.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        loginEmptyLayout.hide()
        logInButton.visibility = View.VISIBLE
        registerLayout.visibility = View.VISIBLE
    }

    private fun showError(error: String?) {
        loginEmptyLayout.setError(error)
        loginEmptyLayout.showError()
    }
}