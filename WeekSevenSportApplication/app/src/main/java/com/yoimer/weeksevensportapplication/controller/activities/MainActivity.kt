package com.yoimer.weeksevensportapplication.controller.activities

import android.os.Bundle
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.yoimer.weeksevensportapplication.R
import com.yoimer.weeksevensportapplication.controller.fragments.SaveFragment
import com.yoimer.weeksevensportapplication.controller.fragments.TeamFragment
import com.yoimer.weeksevensportapplication.databinding.ActivityMainBinding

const val TEAM_SERVICE_URL = "https://api-football-v1.p.rapidapi.com/v2/teams/league/"
const val API_KEY = ""
const val HOST_NAME = "api-football-v1.p.rapidapi.com"

class MainActivity : AppCompatActivity() {
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
            R.id.itemFavorites -> SaveFragment()
            else -> TeamFragment()
        }
    }

}