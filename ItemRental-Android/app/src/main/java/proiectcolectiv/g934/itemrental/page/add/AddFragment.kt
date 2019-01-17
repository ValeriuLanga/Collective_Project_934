package proiectcolectiv.g934.itemrental.page.add

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import kotlinx.android.synthetic.main.fragment_add.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseFragment
import proiectcolectiv.g934.itemrental.utils.EmptyTextChangedListener

class AddFragment : BaseFragment<AddViewModel, AddViewModelProvider>() {

    override fun getViewModelClass() = AddViewModel::class.java

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_add, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupListeners()
        setupSpinner()
    }

    private fun setupSpinner() {
        addTitleEditText.addTextChangedListener(EmptyTextChangedListener(addTitleInput))
        addUsageTypeEditText.addTextChangedListener(EmptyTextChangedListener(addUsageTypeInput))
        addDescriptionEditText.addTextChangedListener(EmptyTextChangedListener(addDescriptionInput))
        addPriceEditText.addTextChangedListener(EmptyTextChangedListener(addPriceInput))
        ArrayAdapter<String>(activity, android.R.layout.simple_spinner_item, resources.getStringArray(R.array.categories_array))
                .also { adapter ->
                    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                    addCategorySpinner.adapter = adapter
                }
    }

    private fun setupListeners() {
        addBackButton.setOnClickListener {
            navController.navigateUp()
        }
        addAddButton.setOnClickListener {
            viewModel.addItem(
                    addTitleEditText.text!!.toString(),
                    addCategorySpinner.selectedItem.toString(),
                    addUsageTypeEditText.text!!.toString(),
                    addDescriptionEditText.text!!.toString(),
                    addPriceEditText.text!!.toString().toInt()
            )
        }
    }
}