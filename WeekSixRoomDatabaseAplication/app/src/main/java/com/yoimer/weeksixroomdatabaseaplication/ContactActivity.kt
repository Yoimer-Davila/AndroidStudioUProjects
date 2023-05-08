package com.yoimer.weeksixroomdatabaseaplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import com.google.gson.Gson
import com.yoimer.weeksixroomdatabaseaplication.database.AppDatabase
import com.yoimer.weeksixroomdatabaseaplication.database.Contact
import com.yoimer.weeksixroomdatabaseaplication.databinding.ActivityContactBinding

class ContactActivity : AppCompatActivity() {
    private lateinit var contact: Contact
    private lateinit var binding: ActivityContactBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityContactBinding.inflate(layoutInflater)
        setContentView(binding.root)
        loadContact()
    }

    private fun loadContact() {
        contact = Gson().fromJson(intent.getStringExtra("contact"), Contact::class.java) ?: Contact(null, "", "")
        if(contact.id != null) {
            binding.etName.setText(contact.name)
            binding.etPhone.setText(contact.phoneNumber)
        }
    }

    private fun saveContact() {
        contact.name = binding.etName.text.toString()
        contact.phoneNumber = binding.etPhone.text.toString()
        if(contact.id == null)
            AppDatabase
                .instance(this)
                .contactDao()
                .insert(contact)

        else AppDatabase
            .instance(this)
            .contactDao()
            .update(contact)

        finish()
    }

    private fun deleteContact() {
        AppDatabase
            .instance(this)
            .contactDao()
            .delete(contact)
        finish()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.contact_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when(item.itemId) {
            R.id.itemSave -> {
                saveContact()
                true
            }
            R.id.itemDelete -> {
                deleteContact()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

}