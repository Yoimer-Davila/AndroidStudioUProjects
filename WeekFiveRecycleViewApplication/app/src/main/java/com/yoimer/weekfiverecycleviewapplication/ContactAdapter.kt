package com.yoimer.weekfiverecycleviewapplication

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView.Adapter
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.yoimer.weekfiverecycleviewapplication.databinding.PrototypeContactBinding

class ContactAdapter(private val contacts: ArrayList<Contact>) : Adapter<ContactPrototype>() {

    // inflate
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ContactPrototype {
        val binding = PrototypeContactBinding.inflate(LayoutInflater.from(parent.context))
        return ContactPrototype(binding.root, binding)
    }

    // link with the adapter
    override fun onBindViewHolder(holder: ContactPrototype, position: Int) {
        holder.bind(contacts[position])
    }

    override fun getItemCount(): Int { return contacts.size }
}

class ContactPrototype(itemView: View, private val binding: PrototypeContactBinding) : ViewHolder(itemView) {

    fun bind(contact: Contact) {
        binding.tvName.text = contact.name
        binding.tvPhone.text = contact.phone
    }
}
