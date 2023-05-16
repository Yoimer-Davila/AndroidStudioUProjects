package com.yoimer.appsuperzound.controller.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.yoimer.appsuperzound.adapters.FavoriteAlbumsAdapter
import com.yoimer.appsuperzound.database.AppDatabase
import com.yoimer.appsuperzound.databinding.FragmentFavoriteAlbumsBinding
import com.yoimer.appsuperzound.models.Album

class FavoriteAlbumsFragment : Fragment(), FavoriteAlbumsAdapter.OnRemoveClickListener {

    private lateinit var binding: FragmentFavoriteAlbumsBinding
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentFavoriteAlbumsBinding.inflate(layoutInflater, container, false)
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.rvFavorites.layoutManager = LinearLayoutManager(context)
        binding.rvFavorites.adapter = FavoriteAlbumsAdapter(ArrayList(AppDatabase
            .instance(requireContext())
            .albumDAO()
            .all()), this)
    }


    override fun onRemoveClicked(album: Album) {
        AppDatabase
            .instance(requireContext())
            .albumDAO()
            .delete(album)

    }

}