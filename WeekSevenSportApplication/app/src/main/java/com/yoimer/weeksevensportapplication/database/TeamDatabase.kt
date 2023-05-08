package com.yoimer.weeksevensportapplication.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.yoimer.weeksevensportapplication.models.Team

@Database(entities = [Team::class], version = 1)
abstract class TeamDatabase : RoomDatabase() {

    abstract fun dao(): TeamDao

    companion object {
        private var INSTANCE: TeamDatabase? = null

        fun instance(context: Context): TeamDatabase {
            if(INSTANCE == null)
                INSTANCE = Room
                    .databaseBuilder(context, TeamDatabase::class.java, "database.db")
                    .allowMainThreadQueries()
                    .build()

            return INSTANCE as TeamDatabase
        }
    }
}