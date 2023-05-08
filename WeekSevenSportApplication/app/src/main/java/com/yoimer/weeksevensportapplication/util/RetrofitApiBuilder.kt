package com.yoimer.weeksevensportapplication.util

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitApiBuilder {
    companion object {
        fun build(host: String): Retrofit {
            return Retrofit.Builder()
                .baseUrl(host)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
        }
    }
}