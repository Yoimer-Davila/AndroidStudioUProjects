package com.yoimer.weeksixroomdatabaseaplication.database

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
class Contact(
    @PrimaryKey(autoGenerate = true)
    var id: Int?,
    @ColumnInfo
    var name: String,
    @ColumnInfo(name = "phone_number")
    var phoneNumber: String)
