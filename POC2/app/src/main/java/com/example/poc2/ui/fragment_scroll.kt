package com.example.poc2.ui

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.fragment.app.Fragment
import com.example.poc2.R

class fragment_scroll : Fragment() {

    private var linearLayout: LinearLayout? = null
    private val brands = arrayOf(
        "Battery", "Camera", "Email", "Location", "Music", "Password",
        "Phone", "Storage", "Tablet", "Time"
    )

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val root = inflater.inflate(R.layout.fragement_scroll, container, false)
        Log.d("Fragment", "Scroll")
        return root
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.d("Fragment", "Scroll")
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        Log.d("Fragment", "Scroll")
        linearLayout = getView()?.findViewById(R.id.linear1)

        for (i in brands.indices) {
            val view: View = layoutInflater.inflate(R.layout.test, linearLayout, false)
            val imageView = view.findViewById<ImageView>(R.id.iv)
            //imageView.setImageResource(images[i])
            val tv = view.findViewById<TextView>(R.id.tv)
            tv.text = brands[i]
            linearLayout?.addView(view)
        }
    }
}