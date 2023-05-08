package com.yoimer.weeksixroomdatabaseaplication

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView.Adapter
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.yoimer.weeksixroomdatabaseaplication.database.Contact
import com.yoimer.weeksixroomdatabaseaplication.databinding.PrototypeContactBinding

class ContactAdapter(private val contacts: List<Contact>, private val onItemClickListener: OnItemClickListener) : Adapter<ContactAdapter.ContactHolder>() {
    class ContactHolder(private val binding: PrototypeContactBinding) : ViewHolder(binding.root) {
        fun bind(contact: Contact, onItemClickListener: OnItemClickListener) {
            binding.tvName.text = contact.name
            binding.tvPhone.text = contact.phoneNumber
            binding.cvContact.setOnClickListener { onItemClickListener.onItemClicked(contact) }
        }

    }

    interface OnItemClickListener {
        fun onItemClicked(contact: Contact)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ContactHolder {
        return ContactHolder(PrototypeContactBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun getItemCount(): Int {
        return contacts.size
    }

    override fun onBindViewHolder(holder: ContactHolder, position: Int) {
        holder.bind(contacts[position], onItemClickListener)
    }

}
