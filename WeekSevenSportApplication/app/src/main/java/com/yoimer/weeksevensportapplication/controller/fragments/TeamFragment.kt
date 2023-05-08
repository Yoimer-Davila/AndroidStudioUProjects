package com.yoimer.weeksevensportapplication.controller.fragments

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.yoimer.weeksevensportapplication.adapter.TeamAdapter
import com.yoimer.weeksevensportapplication.controller.activities.API_KEY
import com.yoimer.weeksevensportapplication.controller.activities.HOST_NAME
import com.yoimer.weeksevensportapplication.controller.activities.TEAM_SERVICE_URL
import com.yoimer.weeksevensportapplication.controller.activities.TeamDetailsActivity
import com.yoimer.weeksevensportapplication.databinding.FragmentTeamBinding
import com.yoimer.weeksevensportapplication.models.ApiResponseHeader
import com.yoimer.weeksevensportapplication.models.Team
import com.yoimer.weeksevensportapplication.network.TeamService
import com.yoimer.weeksevensportapplication.util.RetrofitApiBuilder
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class TeamFragment : Fragment(), TeamAdapter.OnItemClickListener {

    private lateinit var binding: FragmentTeamBinding
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentTeamBinding.inflate(layoutInflater, container, false)
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.rvTeams
        binding.rvTeams.layoutManager = LinearLayoutManager(context)
        loadTeams()
    }

    private fun loadTeams() {
        RetrofitApiBuilder.build(TEAM_SERVICE_URL)
            .create(TeamService::class.java)
            .getTeams(HOST_NAME, API_KEY)
            .enqueue(object : Callback<ApiResponseHeader> {
                override fun onResponse(
                    call: Call<ApiResponseHeader>,
                    response: Response<ApiResponseHeader>
                ) {

                    if(response.isSuccessful) {
                        binding.rvTeams.adapter = TeamAdapter(response.body()!!.api.teams, this@TeamFragment)
                    }
                    else {
                        binding.rvTeams.adapter = TeamAdapter(arrayListOf(Team(
                            1,
                            "Liverpool",
                            "https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/Liverpool_FC.svg/1200px-Liverpool_FC.svg.png",
                            "Anfield"
                        )), this@TeamFragment)
                        Log.d("mainActivity", "Error: ${response.code()}")
                    }

                }

                override fun onFailure(call: Call<ApiResponseHeader>, t: Throwable) {
                    Log.d("mainActivity", t.toString())
                }

            })
    }

    override fun onItemClick(team: Team) {
        Log.d("onItemClick TeamFragment", team.team_id.toString())
        val intent = Intent(context, TeamDetailsActivity::class.java)
        intent.apply {
            putExtra("team", team)
        }

        startActivity(intent)
    }
}