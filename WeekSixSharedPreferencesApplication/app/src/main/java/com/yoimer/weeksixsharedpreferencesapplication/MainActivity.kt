package com.yoimer.weeksixsharedpreferencesapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import com.yoimer.weeksixsharedpreferencesapplication.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)

        val sharePreferences = SharePreferences(this)

        binding.btSave.setOnClickListener {
            sharePreferences.save("name", binding.etName.text.toString())
            Toast.makeText(this, "Data stored", Toast.LENGTH_LONG).show()
        }

        binding.btShow.setOnClickListener {
            val name = sharePreferences.getValue("name")
            if(name != null) {
                Log.d("NAME", name)
                binding.tvName.text = name
            }
        }

        setContentView(binding.root)
    }
}