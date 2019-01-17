package proiectcolectiv.g934.itemrental.page.dialogs

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import kotlinx.android.synthetic.main.dialog_image.*
import proiectcolectiv.g934.itemrental.R

class ChooseImageDialogFragment : DialogFragment() {

    companion object {
        private const val IMAGE_DIALOG = "image_dialog"
        private lateinit var chooseImageDialogListener: ChooseImageDialogListener
        fun createChooseImageDialogFragment(fragmentManager: FragmentManager, chooseImageDialogListener: ChooseImageDialogListener): ChooseImageDialogFragment {
            this.chooseImageDialogListener = chooseImageDialogListener
            return ChooseImageDialogFragment().apply {
                show(fragmentManager, IMAGE_DIALOG)
            }
        }
    }

    private lateinit var imageDialog: Dialog

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        context?.let {
            imageDialog = Dialog(it)
            imageDialog.setContentView(View.inflate(it, R.layout.dialog_image, null))
        }
        return imageDialog
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.dialog_image, container, false)
        imageDialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        dialogCameraImage.setOnClickListener {
            chooseImageDialogListener.onCameraChosen()
            dismiss()
        }
        dialogGalleryImage.setOnClickListener {
            chooseImageDialogListener.onGalleryChosen()
            dismiss()
        }
    }
}

interface ChooseImageDialogListener {
    fun onCameraChosen()

    fun onGalleryChosen()
}