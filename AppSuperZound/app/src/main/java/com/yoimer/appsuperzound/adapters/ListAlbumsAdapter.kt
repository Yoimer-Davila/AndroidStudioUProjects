package com.yoimer.appsuperzound.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView.Adapter
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.squareup.picasso.OkHttp3Downloader
import com.squareup.picasso.Picasso
import com.yoimer.appsuperzound.R
import com.yoimer.appsuperzound.databinding.PrototypeListAlbumBinding
import com.yoimer.appsuperzound.models.Album

class ListAlbumsAdapter(private val albums: List<Album>, private val onFavoriteClicked: OnFavoriteClickListener) : Adapter<ListAlbumsAdapter.ListHolder>() {

    interface OnFavoriteClickListener {
        fun onFavoriteClicked(album: Album)
    }

    class ListHolder(val binding: PrototypeListAlbumBinding) : ViewHolder(binding.root) {
        fun bind(album: Album) {
            Picasso.Builder(binding.root.context)
                .downloader(OkHttp3Downloader(binding.root.context))
                .build()
                .load(album.strAlbumThumb)
                .placeholder(R.mipmap.ic_launcher_foreground)
                .error(R.mipmap.ic_launcher_foreground)
                .into(binding.ivAlbumThumb)

            binding.tvListAlbumName.text = album.strAlbum
            binding.tvAlbumYear.text = album.intYearReleased
            binding.tvAlbumArtist.text = album.strArtist
            binding.rbAlbumScore.rating = album.intScore.toFloat() / 2
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListHolder {
        return ListHolder(PrototypeListAlbumBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun getItemCount(): Int {
        return albums.size
    }

    override fun onBindViewHolder(holder: ListHolder, position: Int) {
        val album = albums[position]
        holder.binding.fabAddFavorite.setOnClickListener { onFavoriteClicked.onFavoriteClicked(album) }
        holder.bind(album)
    }

}