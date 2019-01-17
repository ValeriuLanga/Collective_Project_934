package proiectcolectiv.g934.itemrental.page.add

import android.content.Context
import android.widget.ArrayAdapter
import androidx.annotation.LayoutRes

class AddSpinnerAdapter(context: Context,
                        @LayoutRes resource: Int,
                        objects: Array<String>) : ArrayAdapter<String>(context, resource, objects) {


}