package proiectcolectiv.g934.itemrental.page.login

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.transition.TransitionInflater
import kotlinx.android.synthetic.main.fragment_login.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.utils.LoginTextChangedListener
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull

class LoginFragment : BaseFragment<LoginViewModel, LoginViewModelFactory>() {

    override fun getViewModelClass() = LoginViewModel::class.java

//    private val REQUEST_IMAGE_CAPTURE = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedElementEnterTransition =
                TransitionInflater.from(activity).inflateTransition(android.R.transition.move).apply { duration = 500 }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_login, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupListeners()
    }

    private fun setupListeners() {
        username_edit_text.addTextChangedListener(LoginTextChangedListener(username_input))
        password_edit_text.addTextChangedListener(LoginTextChangedListener(password_input))
        log_in_button.setOnClickListener {
            if (username_input.error.isNullOrEmpty() && password_input.error.isNullOrEmpty()
                && !username_edit_text.text.isNullOrEmpty() && !password_edit_text.text.isNullOrEmpty()
            ) {
                viewModel.loginUser(username_edit_text.text!!.toString(), password_edit_text.text!!.toString())
            } else {
                Toast.makeText(activity, "Fields cannot be empty!", Toast.LENGTH_SHORT).show()
            }
        }
        viewModel.loginLiveData.observeNonNull(this) {
            when (it) {
                is Outcome.Progress -> if (it.loading) showLoading() else hideLoading()
                is Outcome.Success -> {
                    Toast.makeText(activity, "Login successful!", Toast.LENGTH_LONG).show()
                    hideLoading()
                }
                is Outcome.Failure -> {
                    if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                    else showError(it.error.localizedMessage)
                }
            }
        }
        loginEmptyLayout.setRetryClickListener(View.OnClickListener {
            viewModel.loginUser(username_edit_text.text!!.toString(), password_edit_text.text!!.toString())
        })
    }

    private fun showLoading() {
        loginEmptyLayout.showLoading()
        log_in_button.visibility = View.INVISIBLE
        register_layout.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        loginEmptyLayout.hide()
        log_in_button.visibility = View.VISIBLE
        register_layout.visibility = View.VISIBLE
    }

    private fun showError(error: String?) {
        loginEmptyLayout.setError(error)
        loginEmptyLayout.showError()
    }


//    private var mCurrentPhotoPath: String = ""
//
//    private fun createImageFile(): File {
//        // Create an image file name
//        val timeStamp: String = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
//        val storageDir: File? = activity.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
//        return File.createTempFile(
//            "JPEG_${timeStamp}_", /* prefix */
//            ".jpg", /* suffix */
//            storageDir /* directory */
//        ).apply {
//            // Save a file: path for use with ACTION_VIEW intents
//            mCurrentPhotoPath = absolutePath
//        }
//    }
//
//    private fun dispatchTakePictureIntent() {
//        Intent(MediaStore.ACTION_IMAGE_CAPTURE).also { takePictureIntent ->
//            takePictureIntent.resolveActivity(activity.packageManager)?.also {
//                val photoFile: File? = createImageFile()
//                photoFile?.also { file ->
//                    val photoURI: Uri = FileProvider.getUriForFile(
//                        activity,
//                        "com.example.android.fileprovider",
//                        file
//                    )
//                    takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI)
//                    startActivityForResult(takePictureIntent, REQUEST_IMAGE_CAPTURE)
//                }
//            }
//        }
//    }
}