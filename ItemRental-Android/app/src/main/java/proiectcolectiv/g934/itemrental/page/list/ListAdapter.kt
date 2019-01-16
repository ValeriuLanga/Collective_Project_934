package proiectcolectiv.g934.itemrental.page.list

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.extensions.LayoutContainer
import kotlinx.android.synthetic.main.item_rentableitem.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel

class ListAdapter(private val context: Context) : RecyclerView.Adapter<ListAdapter.ListViewHolder>() {

    private var items: List<RentableItemModel> = arrayListOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListViewHolder =
            ListViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_rentableitem, parent, false))

    override fun getItemCount() = items.size

    override fun onBindViewHolder(holder: ListViewHolder, position: Int) = holder.bind(items[position])

    fun setItems(itemList: List<RentableItemModel>) {
        items = itemList
        notifyDataSetChanged()
    }

    inner class ListViewHolder(override val containerView: View) : RecyclerView.ViewHolder(containerView), LayoutContainer {

        fun bind(rentableItemModel: RentableItemModel) = with(rentableItemModel) {
            itemNameTextView.text = title
            userTextView.text = ownerName
            categoryTextView.text = context.getString(R.string.category_separation, category, usageType)
            itemImage.setImageBitmap(image)
        }
    }
}