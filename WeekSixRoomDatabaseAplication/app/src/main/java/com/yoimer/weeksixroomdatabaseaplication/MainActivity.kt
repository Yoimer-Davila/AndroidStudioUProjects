package com.yoimer.weeksixroomdatabaseaplication

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.gson.Gson
import com.yoimer.weeksixroomdatabaseaplication.database.AppDatabase
import com.yoimer.weeksixroomdatabaseaplication.database.Contact
import com.yoimer.weeksixroomdatabaseaplication.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity(), ContactAdapter.OnItemClickListener {
    private lateinit var binding: ActivityMainBinding
    private lateinit var contacts: List<Contact>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }

    override fun onResume() {
        super.onResume()
        loadContacts()
        loadViews()
    }

    private fun loadViews() {
        binding.rvContacts.layoutManager = LinearLayoutManager(this)
        binding.rvContacts.adapter = ContactAdapter(contacts, this)
    }

    private fun loadContacts() {
        contacts = AppDatabase
            .instance(this)
            .contactDao()
            .all()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.main_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        return when(item.itemId) {
            R.id.itemAdd -> {
                startActivity(Intent(this, ContactActivity::class.java))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }

    }

    override fun onItemClicked(contact: Contact) {
        startActivity(Intent(this, ContactActivity::class.java).apply {
            putExtra("contact", Gson().toJson(contact))
        })
    }

}