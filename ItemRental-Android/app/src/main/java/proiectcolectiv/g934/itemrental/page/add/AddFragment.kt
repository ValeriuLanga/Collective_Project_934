package proiectcolectiv.g934.itemrental.page.add

import android.app.Activity.RESULT_OK
import android.app.DatePickerDialog
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.core.content.FileProvider
import com.savvi.rangedatepicker.CalendarPickerView
import kotlinx.android.synthetic.main.fragment_add.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.data.remote.ApiErrorThrowable
import proiectcolectiv.g934.itemrental.page.dialogs.ChooseImageDialogFragment
import proiectcolectiv.g934.itemrental.page.dialogs.ChooseImageDialogListener
import proiectcolectiv.g934.itemrental.utils.EmptyTextChangedListener
import proiectcolectiv.g934.itemrental.utils.Outcome
import proiectcolectiv.g934.itemrental.utils.observeNonNull
import proiectcolectiv.g934.itemrental.utils.showToast
import java.io.File
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.*

class AddFragment : BaseFragment<AddViewModel, AddViewModelProvider>(), ChooseImageDialogListener {

    override fun getViewModelClass() = AddViewModel::class.java

    private val ACTIVITY_REQUEST_CAMERA = 1
    private val ACTIVITY_REQUEST_GALLERY = 0

    private lateinit var datePickerDialog: DatePickerDialog
    private lateinit var chooseImageDialogFragment: ChooseImageDialogFragment
    private var imageChosenBitmap: Bitmap? = null
    private var currentPhotoPath: String? = null

    override fun onDestroy() {
        super.onDestroy()
        val picturesDirectory = activity.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        picturesDirectory?.let {
            val files = it.listFiles()
            for (file in files) {
                file.delete()
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_add, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupListeners()
        setupSpinner()
        setupObservers()
        val fromDateChoose = Calendar.getInstance()
        val toDateChoose = Calendar.getInstance().also { it.add(Calendar.MONTH, 6) }
        addCalendarPickerView.init(fromDateChoose.time, toDateChoose.time)
                .inMode(CalendarPickerView.SelectionMode.RANGE)
    }

    private fun setupSpinner() {
        addTitleEditText.addTextChangedListener(EmptyTextChangedListener(addTitleInput))
        addDescriptionEditText.addTextChangedListener(EmptyTextChangedListener(addDescriptionInput))
        addPriceEditText.addTextChangedListener(EmptyTextChangedListener(addPriceInput))
        ArrayAdapter<String>(
                activity,
                android.R.layout.simple_spinner_item,
                resources.getStringArray(R.array.categories_array)
        )
                .also { adapter ->
                    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                    addCategorySpinner.adapter = adapter
                }
    }

    private fun textFieldsNotEmpty() = !addTitleEditText.text.isNullOrEmpty() &&
            !addDescriptionEditText.text.isNullOrEmpty() &&
            !addPriceEditText.text.isNullOrEmpty() &&
            addCalendarPickerView.selectedDates.size >= 2

    private fun tryAddItem() {
        if (textFieldsNotEmpty() && imageChosenBitmap != null) {
            val dates = addCalendarPickerView.selectedDates
            val simpleDateFormat = SimpleDateFormat("MMM dd yyyy", Locale.getDefault())
            viewModel.addItem(
                    addTitleEditText.text!!.toString(),
                    addCategorySpinner.selectedItem.toString(),
                    addDescriptionEditText.text!!.toString(),
                    addPriceEditText.text!!.toString().toInt(),
                    simpleDateFormat.format(dates[0]),
                    simpleDateFormat.format(dates.last()),
                    currentPhotoPath!!
            )
        } else if (imageChosenBitmap == null) {
            activity.showToast(getString(R.string.choose_or_take_photo))
        } else {
            activity.showToast(getString(R.string.fields_cannot_be_empty))
        }
    }

    private fun setupListeners() {
        addBackButton.setOnClickListener {
            navController.navigateUp()
        }
        addAddButton.setOnClickListener {
            tryAddItem()
        }
        addImage.setOnClickListener {
            fragmentManager?.let { fm ->
                chooseImageDialogFragment = ChooseImageDialogFragment.createChooseImageDialogFragment(fm, this)
            }
        }
        addEmptyLayout.setRetryClickListener(View.OnClickListener {
            tryAddItem()
        })
    }

    private fun setupObservers() {
        viewModel.addItemLiveData.observeNonNull(this) {
            when (it) {
                is Outcome.Progress -> if (it.loading) showLoading() else hideLoading()
                is Outcome.Success -> navController.navigateUp()
                is Outcome.Failure -> {
                    if (it.error is ApiErrorThrowable) showError(it.error.errorResponse.error)
                    else showError(it.error.localizedMessage)
                }
            }
        }
    }

    private fun createImageFile(): File {
        val timeStamp: String = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
        val storageDir: File? = activity.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        return File.createTempFile(
                "JPEG_${timeStamp}_",
                ".jpg",
                storageDir
        ).apply { currentPhotoPath = absolutePath }
    }

    override fun onCameraChosen() {
        Intent(MediaStore.ACTION_IMAGE_CAPTURE).also { takePictureIntent ->
            takePictureIntent.resolveActivity(activity.packageManager)?.also {
                val photoFile: File? = createImageFile()
                photoFile?.also { file ->
                    val photoURI: Uri = FileProvider.getUriForFile(
                            activity,
                            "com.example.android.fileprovider",
                            file
                    )
                    takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI)
                    startActivityForResult(takePictureIntent, ACTIVITY_REQUEST_CAMERA)
                }
            }
        }
    }

    override fun onGalleryChosen() {
        val getIntent = Intent(Intent.ACTION_GET_CONTENT).also { it.type = "image/*" }
        val pickIntent = Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
                .also { it.type = "image/*" }
        val chooserIntent = Intent.createChooser(getIntent, "Select Image")
        chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, arrayOf(pickIntent))
        startActivityForResult(chooserIntent, ACTIVITY_REQUEST_GALLERY)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            ACTIVITY_REQUEST_CAMERA -> {
                if (resultCode == RESULT_OK) {
                    imageChosenBitmap = BitmapFactory.decodeFile(currentPhotoPath)
                    addImage.setImageBitmap(imageChosenBitmap)
                    addImage.rotation = 90F
                }
            }
            ACTIVITY_REQUEST_GALLERY -> {
                if (resultCode == RESULT_OK) {
                    data?.data?.let {
                        val inputStream = activity.contentResolver.openInputStream(it)
                        inputStream?.let { stream ->
                            val photoFile = createImageFile()
                            val fileOutputStream = FileOutputStream(photoFile)
                            fileOutputStream.write(stream.readBytes()).also { fileOutputStream.close() }
                            currentPhotoPath = photoFile.absolutePath
                            imageChosenBitmap = BitmapFactory.decodeFile(currentPhotoPath)
                            addImage.setImageBitmap(imageChosenBitmap)
                            addImage.rotation = 0F
                        }
                    }
                }
            }
        }
    }

    private fun showLoading() {
        addEmptyLayout.showLoading()
        addAddButton.visibility = View.INVISIBLE
    }

    private fun hideLoading() {
        addEmptyLayout.hide()
        addAddButton.visibility = View.INVISIBLE
    }

    private fun showError(error: String?) {
        addEmptyLayout.setError(error)
        addEmptyLayout.showError()
    }
}