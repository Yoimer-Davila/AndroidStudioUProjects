package com.yoimer.weekfourgeoquizapplication

import android.content.Intent
import android.media.MediaPlayer
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.yoimer.weekfourgeoquizapplication.UtilFn.Companion.showShortToast
import com.yoimer.weekfourgeoquizapplication.UtilFn.Companion.strip
import com.yoimer.weekfourgeoquizapplication.databinding.ActivityMainBinding

/*
posibles adiciones:
1. que valide el tamaño del array - done
2. que ponga puntaje - done
3. que se tenga vidas - done
4. mejora del codigo - done
5. Cuando se responda correctamente cambie de color el fondo / sonido - done (sound)
6. Que se pueda escoger temas
7. etc
8. etc
9. que se tenga un banco de pregunta y se tomen "n" preguntas
* */

const val END_GAME = "END_GAME"
const val SCORE = "SCORE"

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var questions: ArrayList<Question>
    private var questionIndex = 0
    private var score = 0
    private var lives = 3
    private lateinit var correctSound: MediaPlayer
    private lateinit var incorrectSound: MediaPlayer
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        loadQuestions()
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupViews()
        initializeScores()
    }

    private fun loadQuestions() {
        questions = ArrayList()
        resources.getStringArray(R.array.questions).forEach { question ->
            val split = question.split(getString(R.string.question_separator))
            if(split.size == 2)
                questions.add(Question(strip(split[0]), strip(split[1]) == "true"))
        }
    }

    private fun checkAnswer(value: Boolean) {
        if(value) {
            correctSound.start()
            showShortToast(this, R.string.correct_message)
            score += 100
            nextQuestion()
            initializeQuestion()
        }
        else {
            incorrectSound.start()
            showShortToast(this, R.string.wrong_message)
            if (lives > 1)
                lives -= 1
            else {
                val intent = Intent(this, EndGameActivity::class.java).apply {
                    putExtra(END_GAME, "Game over")
                    putExtra(SCORE, score)
                }

                startActivity(intent)
            }
        }
        initializeScores()
    }

    private fun nextQuestion() {
        questionIndex = if (questionIndex < questions.size - 1) questionIndex + 1 else {
            val intent = Intent(this, EndGameActivity::class.java).apply {
                putExtra(END_GAME, "You Win")
                putExtra(SCORE, score)
            }

            startActivity(intent)
            questionIndex
        }
    }

    private fun initializeScores() {
        binding.tvScore.text = getString(R.string.score).format(score)
        binding.tvLives.text = getString(R.string.lives).format(lives)
    }

    private fun initializeQuestion() {
        if (questionIndex < questions.size)
            binding.tvQuestion.text = questions[questionIndex].sentence
    }

    private fun setupViews() {
        correctSound  = MediaPlayer.create(this, R.raw.correct)
        incorrectSound = MediaPlayer.create(this, R.raw.wrong)
        binding.btTrue.setOnClickListener { checkAnswer(questions[questionIndex].answer) }
        binding.btFalse.setOnClickListener { checkAnswer(!questions[questionIndex].answer) }
        initializeQuestion()
    }

    override fun onDestroy() {
        super.onDestroy()
        correctSound.release()
        incorrectSound.release()
    }
}