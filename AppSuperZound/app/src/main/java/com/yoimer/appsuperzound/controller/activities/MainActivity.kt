package com.yoimer.appsuperzound.controller.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import androidx.fragment.app.Fragment
import com.yoimer.appsuperzound.R
import com.yoimer.appsuperzound.controller.fragments.FavoriteAlbumsFragment
import com.yoimer.appsuperzound.controller.fragments.HomeFragment
import com.yoimer.appsuperzound.controller.fragments.ListAlbumsFragment
import com.yoimer.appsuperzound.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    companion object {
        const val API_PATH = "https://theaudiodb.com/api/v1/"
    }
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        initViews()
        navigateTo(binding.bnvMenu.menu.findItem(R.id.itemHome))
    }

    private fun initViews() {
        binding.bnvMenu.setOnItemSelectedListener { navigateTo(it) }
    }

    private fun navigateTo(item: MenuItem): Boolean {
        item.isChecked = true
        return supportFragmentManager
            .beginTransaction()
            .replace(binding.flFragment.id, fragmentFor(item))
            .commit() > 0
    }

    private fun fragmentFor(item: MenuItem): Fragment {
        return when(item.itemId) {
            R.id.itemFavorites -> FavoriteAlbumsFragment()
            R.id.itemList -> ListAlbumsFragment()
            else -> HomeFragment()
        }
    }
}