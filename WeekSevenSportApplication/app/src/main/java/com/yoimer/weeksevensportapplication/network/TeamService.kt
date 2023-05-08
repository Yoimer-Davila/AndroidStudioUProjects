package com.yoimer.weeksevensportapplication.network

import com.yoimer.weeksevensportapplication.models.ApiResponseHeader
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Header


interface TeamService {

    @GET("1341")
    fun getTeams(@Header("x-rapidapi-host")host: String,
                 @Header("x-rapidapi-key")key: String): Call<ApiResponseHeader>
}