package com.yoimer.weeksevensportapplication.controller.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.squareup.picasso.OkHttp3Downloader
import com.squareup.picasso.Picasso
import com.yoimer.weeksevensportapplication.databinding.ActivityTeamDetailsBinding
import com.yoimer.weeksevensportapplication.database.TeamDatabase
import com.yoimer.weeksevensportapplication.models.Team

class TeamDetailsActivity : AppCompatActivity() {
    private lateinit var binding: ActivityTeamDetailsBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTeamDetailsBinding.inflate(layoutInflater)
        setContentView(binding.root)

        initFields()
    }

    private fun initFields() {
        val team: Team = intent.getSerializableExtra("team") as Team

        Picasso
            .Builder(this)
            .downloader(OkHttp3Downloader(this))
            .build()
            .load(team.logo)
            .into(binding.ivDetailLogo)

        binding.tvDetailName.text = team.name
        binding.tvDetailStadium.text = team.venue_name
        binding.fbSave.setOnClickListener {
            TeamDatabase
                .instance(this)
                .dao()
                .insertTeam(team)
            finish()
        }
    }
}