package com.yoimer.appsuperzound.controller.fragments

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.yoimer.appsuperzound.adapters.ListAlbumsAdapter
import com.yoimer.appsuperzound.controller.activities.MainActivity.Companion.API_PATH
import com.yoimer.appsuperzound.database.AppDatabase
import com.yoimer.appsuperzound.databinding.FragmentListAlbumsBinding
import com.yoimer.appsuperzound.models.Album
import com.yoimer.appsuperzound.models.ApiResponse
import com.yoimer.appsuperzound.networking.AlbumService
import com.yoimer.appsuperzound.networking.RetrofitApiBuilder
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ListAlbumsFragment : Fragment(), ListAlbumsAdapter.OnFavoriteClickListener {

    private lateinit var binding: FragmentListAlbumsBinding
    private var albums: List<Album> = ArrayList()
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentListAlbumsBinding.inflate(layoutInflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.rvListAlbums.layoutManager = LinearLayoutManager(context)
        loadAlbums()
    }

    private fun loadAlbums() {
        RetrofitApiBuilder
            .build(API_PATH)
            .create(AlbumService::class.java)
            .getAll()
            .enqueue(object : Callback<ApiResponse> {
                override fun onResponse(call: Call<ApiResponse>, response: Response<ApiResponse>) {
                    if(response.isSuccessful) {
                        albums = response.body()!!.loved
                        binding.rvListAlbums.adapter = ListAlbumsAdapter(albums, this@ListAlbumsFragment)
                    }
                    else Log.d("listsFragment", "RESPONSE NOT SUCCESSFULLY")
                }

                override fun onFailure(call: Call<ApiResponse>, t: Throwable) {
                    Log.d("listsFragment", t.toString())
                }

            })

    }

    override fun onFavoriteClicked(album: Album) {
        AppDatabase
            .instance(requireContext())
            .albumDAO()
            .insert(album)
    }


}