package com.yoimer.weeksevensportapplication.controller.fragments

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.yoimer.weeksevensportapplication.R
import com.yoimer.weeksevensportapplication.adapter.TeamAdapter
import com.yoimer.weeksevensportapplication.database.TeamDatabase
import com.yoimer.weeksevensportapplication.databinding.FragmentSaveBinding
import com.yoimer.weeksevensportapplication.models.Team


class SaveFragment : Fragment(), TeamAdapter.OnItemClickListener {
    private lateinit var binding: FragmentSaveBinding
    private var teams: List<Team> = ArrayList()
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentSaveBinding.inflate(layoutInflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        teams = TeamDatabase
            .instance(view.context)
            .dao()
            .getAllTeams()
        binding.rvTeamSave.layoutManager = LinearLayoutManager(context)
        binding.rvTeamSave.adapter = TeamAdapter(teams, this)
    }

    override fun onItemClick(team: Team) {
        Log.d("onItemClick SaveFragment", team.name)
    }
}