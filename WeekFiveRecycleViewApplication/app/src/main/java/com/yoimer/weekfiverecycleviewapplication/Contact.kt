package com.yoimer.weekfiverecycleviewapplication

class Contact(init: Contact.() -> Unit) {
    lateinit var name: String
    lateinit var phone: String

    constructor(name: String, phone: String) : this({
        this.name = name
        this.phone = phone
    })

    init {
        init()
    }
}