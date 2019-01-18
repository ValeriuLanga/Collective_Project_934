package proiectcolectiv.g934.itemrental.page.details

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import kotlinx.android.extensions.LayoutContainer
import kotlinx.android.synthetic.main.item_rentableitem_details.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.data.remote.model.RentableItemModel

class DetailsAdapter(
        private val context: Context,
        private val rentableItemClickedListener: RentableItemClickedListener
) : RecyclerView.Adapter<DetailsAdapter.ListViewHolder>() {

    private var items: List<RentableItemModel> = arrayListOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListViewHolder =
            ListViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_rentableitem_details, parent, false))

    override fun getItemCount() = items.size

    override fun onBindViewHolder(holder: ListViewHolder, position: Int) = holder.bind(items[position])

    fun setItems(itemList: List<RentableItemModel>) {
        items = itemList
        notifyDataSetChanged()
    }

    inner class ListViewHolder(override val containerView: View) : RecyclerView.ViewHolder(containerView),
            LayoutContainer {

        init {
            rootView.setOnClickListener {
                rentableItemClickedListener.onRentableItemClicked(items[adapterPosition])
            }
        }

        fun bind(rentableItemModel: RentableItemModel) = with(rentableItemModel) {
            itemNameTextView.text = title
            userTextView.text = ownerName
            categoryTextView.text = category
            if (imagePath == null) {
                itemImage.setImageDrawable(context.getDrawable(R.mipmap.ic_logo_foreground))
            } else {
                Glide.with(itemImage)
                        .load(imagePath)
                        .into(itemImage)
            }
            Unit
        }
    }

    interface RentableItemClickedListener {
        fun onRentableItemClicked(rentableItemModel: RentableItemModel)
    }
}