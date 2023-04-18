package com.yoimer.weekfourgeoquizapplication

import android.content.Context
import android.widget.Toast

class UtilFn {
    companion object {
        fun showShortToast(context: Context, stringId: Int) {
            showToast(context, stringId, Toast.LENGTH_SHORT)
        }

        fun showLongToast(context: Context, stringId: Int) {
            showToast(context, stringId, Toast.LENGTH_LONG)
        }

        private fun showToast(context: Context, stringId: Int, time: Int) {
            Toast.makeText(context, context.getString(stringId), time).show()
        }

        fun strip(text: String): String {
            return text.trim().replace("\\s+".toRegex(), " ")
        }
    }
}