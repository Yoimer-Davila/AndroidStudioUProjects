package com.yoimer.weeksixroomdatabaseaplication.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = [Contact::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun contactDao(): ContactDAO
    companion object {
        private var INSTANCE: AppDatabase? = null
        private const val DATABASE_NAME = "contacts.db"
        fun instance(context: Context): AppDatabase {
            if(INSTANCE == null)
                INSTANCE = Room
                    .databaseBuilder(context, AppDatabase::class.java, DATABASE_NAME)
                    .allowMainThreadQueries()
                    .build()
            return INSTANCE as AppDatabase
        }

    }
}