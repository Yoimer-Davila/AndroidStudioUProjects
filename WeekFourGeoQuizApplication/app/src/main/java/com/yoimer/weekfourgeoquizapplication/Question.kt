package com.yoimer.weekfourgeoquizapplication

class Question(init: Question.() -> Unit) {

    var sentence: String = ""
    var answer: Boolean = false

    constructor(sentence: String, answer: Boolean) : this({}) {
        this.sentence = sentence
        this.answer = answer
    }

    init {
        init()
    }
}