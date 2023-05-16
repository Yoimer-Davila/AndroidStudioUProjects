package com.yoimer.appsuperzound.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.yoimer.appsuperzound.models.Album

@Database(entities = [Album::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun albumDAO(): AlbumDAO

    companion object {
        private var INSTANCE: AppDatabase? = null

        fun instance(context: Context): AppDatabase {
            if(INSTANCE == null)
                INSTANCE = Room
                    .databaseBuilder(context, AppDatabase::class.java, "database.db")
                    .allowMainThreadQueries()
                    .build()

            return INSTANCE as AppDatabase
        }
    }
}