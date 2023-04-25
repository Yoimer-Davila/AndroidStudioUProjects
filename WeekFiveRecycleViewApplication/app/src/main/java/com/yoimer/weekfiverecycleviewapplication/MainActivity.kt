package com.yoimer.weekfiverecycleviewapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.yoimer.weekfiverecycleviewapplication.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    private val contacts = ArrayList<Contact>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        loadContacts()
        initView()
    }

    private fun initView() {
        binding.rvContacts.adapter = ContactAdapter(contacts) // adapter
        binding.rvContacts.layoutManager = LinearLayoutManager(this)
    }

    private fun loadContacts() {
        contacts.add(Contact("Juan", "123456789"))
        contacts.add(Contact("Carlos", "123456789"))
        contacts.add(Contact("Pedro", "123456789"))
        contacts.add(Contact("Lucas", "123456789"))
        contacts.add(Contact("Alexa", "123456789"))
        contacts.add(Contact("Juana", "123456789"))
        contacts.add(Contact("Yoimer", "123456789"))
        contacts.add(Contact("Dani", "123456789"))
        contacts.add(Contact("Daniela", "123456789"))

        contacts.add(Contact("Juan", "123456789"))
        contacts.add(Contact("Carlos", "123456789"))
        contacts.add(Contact("Pedro", "123456789"))
        contacts.add(Contact("Lucas", "123456789"))
        contacts.add(Contact("Alexa", "123456789"))
        contacts.add(Contact("Juana", "123456789"))
        contacts.add(Contact("Yoimer", "123456789"))
        contacts.add(Contact("Dani", "123456789"))
        contacts.add(Contact("Daniela", "123456789"))
    }
}