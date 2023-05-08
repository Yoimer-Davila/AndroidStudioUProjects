package com.yoimer.weeksevensportapplication.models

data class ApiResponseDetails(
    val results: Int,
    val teams: List<Team>
)
