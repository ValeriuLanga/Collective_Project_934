package proiectcolectiv.g934.itemrental.page.dialogs

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.savvi.rangedatepicker.CalendarPickerView
import kotlinx.android.synthetic.main.dialog_rent.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.data.remote.model.RentPeriodModel
import java.text.SimpleDateFormat
import java.util.*

class RentDialogFragment : DialogFragment() {

    companion object {
        private const val RENT_DIALOG = "rent_dialog"
        private lateinit var rentDialogListener: RentDialogListener
        private lateinit var ignoredRentalPeriods: List<RentPeriodModel>
        private lateinit var rentStartTime: String
        private lateinit var rentEndTime: String
        fun createRentDialogFragment(
                fm: FragmentManager, rentDialogListener: RentDialogListener,
                ignoredPeriods: List<RentPeriodModel>,
                rentStartTime: String,
                rentEndTime: String
        ): RentDialogFragment {
            this.rentDialogListener = rentDialogListener
            this.ignoredRentalPeriods = ignoredPeriods
            this.rentStartTime = rentStartTime
            this.rentEndTime = rentEndTime
            return RentDialogFragment().apply {
                show(fm, RENT_DIALOG)
            }
        }
    }

    private lateinit var rentDialog: Dialog
    private var deactivatedDates = listOf<Date>()

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        context?.let {
            rentDialog = Dialog(it)
            rentDialog.setContentView(View.inflate(it, R.layout.dialog_rent, null))
        }
        return rentDialog
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.dialog_rent, container, false)
        rentDialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupCalendar()
        dialogRentButton.setOnClickListener {
            val selectedDates = dialogRentCalendar.selectedDates
            when (selectedDates.size) {
                0 -> dialogRentError.text = getString(R.string.no_range_selected)
                1 -> rentDialogListener.rentItem(dialogRentCalendar.selectedDate, dialogRentCalendar.selectedDate)
                else -> {
                    val selectedDatesList = generateDateRangeFromDates(selectedDates[0], selectedDates.last())
                    selectedDatesList.forEach { date ->
                        if (deactivatedDates.contains(date)) {
                            dialogRentError.text = getString(R.string.incorrect_range)
                            return@setOnClickListener
                        }
                    }
                    rentDialogListener.rentItem(selectedDatesList[0], selectedDatesList.last())
                }
            }
        }
    }

    private fun setupCalendar() {
        val sdf = SimpleDateFormat("MMM dd yyyy", Locale.getDefault())
        val startDate = sdf.parse(rentStartTime)
        val endDate = Calendar.getInstance().run {
            time = sdf.parse(rentEndTime)
            add(Calendar.DAY_OF_MONTH, 1)
            time
        }
        deactivatedDates = generateDateRanges(sdf)
        dialogRentCalendar.init(startDate, endDate).inMode(CalendarPickerView.SelectionMode.RANGE)
                .withHighlightedDates(deactivatedDates)
    }

    private fun generateDateRangeFromDates(startDate: Date, endDate: Date): List<Date> {
        val list = mutableListOf<Date>()
        while (startDate.time < endDate.time + 8.64e+7.toLong()) {
            Date().also {
                it.time = startDate.time
                list.add(it)
            }
            startDate.time += 8.64e+7.toLong()
        }
        return list
    }

    private fun generateDateRanges(formatter: SimpleDateFormat): List<Date> {
        val list = mutableListOf<Date>()
        ignoredRentalPeriods.forEach { period ->
            val startDate = formatter.parse(period.startDate)
            val endDate = formatter.parse(period.endDate)
            list.addAll(generateDateRangeFromDates(startDate, endDate))
        }
        return list
    }

    fun startLoading() {
        dialogRentEmptylayout.showLoading()
        dialogRentButton.visibility = View.INVISIBLE
    }
}

interface RentDialogListener {

    fun rentItem(startDate: Date, endDate: Date)
}