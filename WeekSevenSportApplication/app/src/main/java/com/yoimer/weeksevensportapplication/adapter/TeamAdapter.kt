package com.yoimer.weeksevensportapplication.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView.Adapter
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.squareup.picasso.OkHttp3Downloader
import com.squareup.picasso.Picasso
import com.yoimer.weeksevensportapplication.R
import com.yoimer.weeksevensportapplication.databinding.PrototypeTeamBinding
import com.yoimer.weeksevensportapplication.models.Team

class TeamAdapter(private val teams: List<Team>, private val itemClickListener: OnItemClickListener): Adapter<TeamAdapter.TeamHolder>() {
    class TeamHolder(val binding: PrototypeTeamBinding) : ViewHolder(binding.root) {

        fun bind(team: Team) {
            binding.tvTeamName.text = team.name
            Picasso.Builder(binding.root.context)
                .downloader(OkHttp3Downloader(binding.root.context))
                .build()
                .load(team.logo)
                .placeholder(R.drawable.ic_launcher_background)
                .error(R.drawable.ic_launcher_background)
                .into(binding.ivLogo)
        }
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TeamHolder {
        return TeamHolder(PrototypeTeamBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun onBindViewHolder(holder: TeamHolder, position: Int) {
        val team = teams[position]
        holder.bind(team)
        holder.binding.cvTeam.setOnClickListener {
            itemClickListener.onItemClick(team)
        }
    }

    override fun getItemCount(): Int {
        return teams.size
    }


    interface OnItemClickListener {
        fun onItemClick(team: Team)
    }

}