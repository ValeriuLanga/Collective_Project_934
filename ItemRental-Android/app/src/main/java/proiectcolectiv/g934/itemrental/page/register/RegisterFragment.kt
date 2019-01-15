package proiectcolectiv.g934.itemrental.page.register

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.transition.TransitionInflater
import kotlinx.android.synthetic.main.fragment_register.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.data.remote.model.LocationModel
import proiectcolectiv.g934.itemrental.data.remote.model.UserModel
import proiectcolectiv.g934.itemrental.utils.*

class RegisterFragment : BaseFragment<RegisterViewModel, RegisterViewModelFactory>() {

    override fun getViewModelClass() = RegisterViewModel::class.java

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        TransitionInflater.from(activity).inflateTransition(android.R.transition.move).apply {
            duration = 300
            this@RegisterFragment.sharedElementEnterTransition = this
            this@RegisterFragment.sharedElementReturnTransition = this
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_register, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupTextFields()
        setupListeners()
        setupObservers()
    }

    private fun setupTextFields() {
        userEditText.addTextChangedListener(EmptyTextChangedListener(userInput))
        passwordEditText.addTextChangedListener(EmptyTextChangedListener(passwordInput))
        emailEditText.addTextChangedListener(EmptyTextChangedListener(emailInput))
        phoneNumberEditText.addTextChangedListener(EmptyTextChangedListener(phoneNumberInput))
        cityEditText.addTextChangedListener(EmptyTextChangedListener(cityInput))
        streetEditText.addTextChangedListener(EmptyTextChangedListener(streetInput))
    }

    private fun textFieldsNotEmpty() = !userEditText.text.isNullOrEmpty() &&
            !passwordEditText.text.isNullOrEmpty() &&
            !phoneNumberEditText.text.isNullOrEmpty() &&
            !cityEditText.text.isNullOrEmpty() &&
            !streetEditText.text.isNullOrEmpty()

    private fun emailEditTextIsValidEmail() = emailEditText.text?.toString()?.isValidEmail()
            ?: false

    private fun setupListeners() {
        cancelButton.setOnClickListener {
            navController.navigateUp()
        }
        registerButton.setOnClickListener {
            registerUser()
        }
        registerEmptyLayout.setRetryClickListener(View.OnClickListener {
            registerUser()
        })
    }

    private fun registerUser() {
        when {
            textFieldsNotEmpty() && emailEditTextIsValidEmail() -> viewModel.registerUser(UserModel(
                    userEditText.text!!.toString(),
                    passwordEditText.text!!.toString(),
                    emailEditText.text!!.toString(),
                    0,
                    phoneNumberEditText.text!!.toString(),
                    LocationModel(
                            cityEditText.text!!.toString(),
                            streetEditText.text!!.toString(),
                            1111.0,
                            1111.0
                    ))
            )
            !emailEditTextIsValidEmail() -> emailInput.error = getString(R.string.not_valid_email)
            else -> activity.showToast(getString(R.string.fields_cannot_be_empty))
        }
        if (textFieldsNotEmpty())
        else activity.showToast(getString(R.string.fields_cannot_be_empty))
    }

    private fun setupObservers() {
        viewModel.registerLiveData.observeNonNull(this) { singleEvent ->
            singleEvent.getContentIfNotHandled()?.let {
                when (it) {
                    is Outcome.Progress -> if (it.loading) showLoading() else hideLoading()
                    is Outcome.Success -> {
                        activity.showToast(getString(R.string.register_successful))
                        navController.navigateUp()
                    }
                    is Outcome.Failure -> {
                        if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                        else showError(it.error.localizedMessage)
                    }
                }
            }
        }
    }

    private fun showLoading() {
        registerEmptyLayout.showLoading()
        registerButton.visibility = View.INVISIBLE
        cancelButton.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        registerEmptyLayout.hide()
        registerButton.visibility = View.VISIBLE
        cancelButton.visibility = View.VISIBLE
    }

    private fun showError(error: String?) {
        registerEmptyLayout.setError(error)
        registerEmptyLayout.showError()
    }
}