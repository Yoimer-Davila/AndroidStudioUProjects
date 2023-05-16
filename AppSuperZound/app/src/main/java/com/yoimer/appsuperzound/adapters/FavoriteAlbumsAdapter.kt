package com.yoimer.appsuperzound.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.Adapter
import com.squareup.picasso.OkHttp3Downloader
import com.squareup.picasso.Picasso
import com.yoimer.appsuperzound.R
import com.yoimer.appsuperzound.databinding.PrototypeFavoriteAlbumBinding
import com.yoimer.appsuperzound.models.Album

class FavoriteAlbumsAdapter(private val albums: ArrayList<Album>, private val onRemoveClickListener: OnRemoveClickListener) : Adapter<FavoriteAlbumsAdapter.FavoriteHolder>() {
    interface OnRemoveClickListener {
        fun onRemoveClicked(album: Album)
    }

    class FavoriteHolder(val binding: PrototypeFavoriteAlbumBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(album: Album) {
            Picasso.Builder(binding.root.context)
                .downloader(OkHttp3Downloader(binding.root.context))
                .build()
                .load(album.strAlbum3DCase)
                .placeholder(R.mipmap.ic_launcher_foreground)
                .error(R.mipmap.ic_launcher_foreground)
                .into(binding.ivAlbumCase)

            binding.tvAlbumGenre.text = album.strGenre
            binding.tvFavAlbumName.text = album.strAlbum

        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FavoriteHolder {
        return FavoriteHolder(PrototypeFavoriteAlbumBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun getItemCount(): Int {
        return albums.size
    }

    override fun onBindViewHolder(holder: FavoriteHolder, position: Int) {
        val album = albums[position]
        holder.bind(album)
        holder.binding.fabRemoveFavorite.setOnClickListener {
            onRemoveClickListener.onRemoveClicked(album)
            albums.remove(album)
            notifyItemRemoved(position)
        }
    }

}