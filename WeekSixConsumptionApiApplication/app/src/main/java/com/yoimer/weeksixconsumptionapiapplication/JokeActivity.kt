package com.yoimer.weeksixconsumptionapiapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.yoimer.weeksixconsumptionapiapplication.databinding.ActivityJokeBinding
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class JokeActivity : AppCompatActivity() {
    private lateinit var binding: ActivityJokeBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityJokeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        binding.btJoke.setOnClickListener {
            loadJoke()
        }
    }

    private fun loadJoke() {
        val retrofit = Retrofit.Builder()
            .baseUrl("https://geek-jokes.sameerkumar.website/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        val jokeService: JokeService = retrofit.create(JokeService::class.java)
        val request = jokeService.getJoke("json")

        request.enqueue(object : Callback<Joke> {
            override fun onResponse(call: Call<Joke>, response: Response<Joke>) {
                if(response.isSuccessful)
                    binding.tvJoke.text = response.body()!!.joke
            }

            override fun onFailure(call: Call<Joke>, t: Throwable) {
                Log.d("JOKE", t.toString())
            }

        })
        //binding.tvJoke.text = "Showed Joke"
    }
}