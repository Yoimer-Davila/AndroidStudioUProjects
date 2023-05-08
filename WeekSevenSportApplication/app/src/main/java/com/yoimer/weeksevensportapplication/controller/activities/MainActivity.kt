package com.yoimer.weeksevensportapplication.controller.activities

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.yoimer.weeksevensportapplication.adapter.TeamAdapter
import com.yoimer.weeksevensportapplication.controller.fragments.TeamFragment
import com.yoimer.weeksevensportapplication.databinding.ActivityMainBinding
import com.yoimer.weeksevensportapplication.models.ApiResponseHeader
import com.yoimer.weeksevensportapplication.network.TeamService
import com.yoimer.weeksevensportapplication.util.RetrofitApiBuilder
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

const val TEAM_SERVICE_URL = "https://api-football-v1.p.rapidapi.com/v2/teams/league/"
const val API_KEY = ""
const val HOST_NAME = "api-football-v1.p.rapidapi.com"

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }


}