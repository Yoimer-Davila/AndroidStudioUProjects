package com.yoimer.weeksixroomdatabaseaplication.database

import androidx.room.*

@Dao
interface ContactDAO : CrudDAO<Contact> {
    @Query("SELECT * FROM Contact")
    fun all(): List<Contact>

}