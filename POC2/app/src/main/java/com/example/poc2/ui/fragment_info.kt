package com.example.poc2.ui

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.poc2.R

class fragment_info : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val root = inflater.inflate(R.layout.fragement_info, container, false)
        Log.d("Fragment", "Info")
        return root
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.d("Fragment", "Info")
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        Log.d("Fragment", "Info")
    }
}