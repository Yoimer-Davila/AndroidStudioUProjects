package com.yoimer.weekfourgeoquizapplication

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.yoimer.weekfourgeoquizapplication.databinding.ActivityEndGameBinding


class EndGameActivity : AppCompatActivity() {

    private lateinit var binding: ActivityEndGameBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityEndGameBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.tvEndMessage.text = getString(R.string.end_message)
            .format(intent.getStringExtra(END_GAME), intent.getIntExtra(SCORE, 0))
    }
}