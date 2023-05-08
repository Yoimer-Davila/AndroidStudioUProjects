package com.yoimer.weeksevensportapplication.models

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import java.io.Serializable

@Entity(tableName = "teams")
data class Team(
    @PrimaryKey(autoGenerate = true)
    val team_id: Int,
    @ColumnInfo
    val name: String,
    @ColumnInfo
    val logo: String,
    @ColumnInfo
    val venue_name: String
): Serializable