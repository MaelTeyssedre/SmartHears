package com.smarthears.poc2

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.smarthears.poc2.databinding.ActivityMainBinding

class MainActivity :
    AppCompatActivity() {

    private var clicks: Int = 2

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(
        savedInstanceState: Bundle?
    ) {
        super.onCreate(
            savedInstanceState
        )

        binding =
            ActivityMainBinding.inflate(
                layoutInflater
            )
        setContentView(
            binding.root
        )
        val text = findViewById<TextView>(R.id.textView)
        text.text = "$clicks"

        val clickButton = findViewById<Button>(R.id.button)
        clickButton.setOnClickListener {
            clicks = cppFunction(clicks)
            text.text = "$clicks"
        }
    }

    /**
     * A native method that is implemented by the 'poc2' native library,
     * which is packaged with this application.
     */
    external fun cppFunction(nb: Int): Int

    companion object {
        // Used to load the 'poc2' library on application startup.
        init {
            System.loadLibrary(
                "poc2"
            )
        }
    }
}