package com.smarthears.poc

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView

class MainActivity :
    AppCompatActivity() {

    private var clicks: Int = 0

    override fun onCreate(
        savedInstanceState: Bundle?
    ) {
        super.onCreate(
            savedInstanceState
        )
        setContentView(
            R.layout.activity_main
        )
        val text = findViewById<TextView>(R.id.textView)
        text.text = "$clicks"

        val clickButton = findViewById<Button>(R.id.button)
        clickButton.setOnClickListener {
            clicks++
            text.text = "$clicks"
        }
    }
}
