package com.yoimer.appsuperzound.networking

import com.yoimer.appsuperzound.models.Album
import com.yoimer.appsuperzound.models.ApiResponse
import retrofit2.Call
import retrofit2.http.GET

interface AlbumService {
    @GET("json/523532/mostloved.php?format=album")
    fun getAll(): Call<ApiResponse>
}