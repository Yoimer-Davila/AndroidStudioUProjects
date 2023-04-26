package com.yoimer.weeksixsharedpreferencesapplication

import android.content.Context
import android.content.Context.MODE_PRIVATE
import android.content.SharedPreferences

class SharePreferences(context: Context) {
    companion object {
        const val NAME = "preferences"
    }
    private val sharePreferences = context.getSharedPreferences(NAME, MODE_PRIVATE)

    private fun editor(): SharedPreferences.Editor { return sharePreferences.edit() }

    fun save(key: String, value: String) {
        editor().apply {
            putString(key, value)
            commit()
        }
    }

    fun getValue(key: String): String? {
        return sharePreferences.getString(key, null)
    }

    fun clear() {
        editor().apply {
            clear()
            commit()
        }
    }

    fun removeValue(key: String) {
        editor().apply {
            remove(key)
            commit()
        }
    }
}