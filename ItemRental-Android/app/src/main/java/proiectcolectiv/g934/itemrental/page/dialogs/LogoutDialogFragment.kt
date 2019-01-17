package proiectcolectiv.g934.itemrental.page.dialogs

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import kotlinx.android.synthetic.main.dialog_logout.*
import proiectcolectiv.g934.itemrental.R

class LogoutDialogFragment : DialogFragment() {

    companion object {
        private const val LOGOUT_DIALOG = "logout_dialog"
        private lateinit var logoutDialogListener: LogoutDialogListener
        fun createLogoutDialogFragment(fragmentManager: FragmentManager, logoutDialogListener: LogoutDialogListener): LogoutDialogFragment {
            this.logoutDialogListener = logoutDialogListener
            return LogoutDialogFragment().apply {
                show(fragmentManager, LOGOUT_DIALOG)
            }
        }
    }

    private lateinit var logoutDialog: Dialog

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        context?.let { it ->
            logoutDialog = Dialog(it)
            logoutDialog.setContentView(View.inflate(it, R.layout.dialog_logout, null))
        }
        return logoutDialog
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.dialog_logout, container, false)
        logoutDialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        dialogLogoutYesButton.setOnClickListener {
            logoutDialogListener.logoutConfirmed()
            dismiss()
        }
        dialogLogoutNoButton.setOnClickListener {
            dismiss()
        }
    }
}

interface LogoutDialogListener {

    fun logoutConfirmed()
}
