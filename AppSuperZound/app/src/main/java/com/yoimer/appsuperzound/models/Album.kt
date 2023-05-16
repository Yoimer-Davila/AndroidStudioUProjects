package com.yoimer.appsuperzound.models

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey


@Entity(tableName = "albums")
data class Album(
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    @ColumnInfo(name = "album")
    val strAlbum: String,
    @ColumnInfo(name = "artist")
    val strArtist: String,
    @ColumnInfo(name = "album_thumb")
    val strAlbumThumb: String,
    @ColumnInfo(name = "year_released")
    val intYearReleased: String,
    @ColumnInfo(name = "score")
    val intScore: String,
    @ColumnInfo(name = "album_3d_case")
    val strAlbum3DCase: String,
    @ColumnInfo(name = "genre")
    val strGenre: String
)