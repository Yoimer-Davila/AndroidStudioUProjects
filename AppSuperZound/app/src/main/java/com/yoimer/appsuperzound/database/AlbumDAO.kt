package com.yoimer.appsuperzound.database

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import com.yoimer.appsuperzound.models.Album

@Dao
interface AlbumDAO {
    @Query("SELECT * FROM albums")
    fun all(): List<Album>

    @Insert
    fun insert(vararg album: Album)

    @Delete
    fun delete(vararg album: Album)

}