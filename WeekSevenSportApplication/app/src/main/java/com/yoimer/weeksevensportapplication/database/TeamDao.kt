package com.yoimer.weeksevensportapplication.database

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import com.yoimer.weeksevensportapplication.models.Team

@Dao
interface TeamDao {

    @Query("SELECT * from teams")
    fun getAllTeams(): List<Team>

    @Insert
    fun insertTeam(team: Team)

    @Update
    fun updateTeam(team: Team)

    @Delete
    fun deleteTeam(team: Team)
}