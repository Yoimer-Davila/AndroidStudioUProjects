package com.yoimer.weeksixroomdatabaseaplication.database

import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Update


interface CrudDAO<Entity> {
    @Insert
    fun insert(vararg entity: Entity)

    @Insert
    fun insert(entities: List<Entity>)

    @Delete
    fun delete(vararg entity: Entity)

    @Update
    fun update(vararg entity: Entity)

}