package com.example.poc2;
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.poc2.R

class MainActivity : AppCompatActivity() {

    private var linearLayout: LinearLayout? = null
    private val brands = arrayOf("Battery", "Camera", "Email", "Location", "Music", "Password",
        "Phone", "Storage" , "Tablet", "Time")
    private val images = intArrayOf(
        R.drawable.battery, R.drawable.camera, R.drawable.email,
        R.drawable.location, R.drawable.music, R.drawable.password, R.drawable.phone,
        R.drawable.storage, R.drawable.tablet, R.drawable.time)


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        linearLayout = findViewById(R.id.linear1)
        val layoutInflater = LayoutInflater.from(this)

        for (i in brands.indices)
        {
            val view: View = layoutInflater.inflate(R.layout.test, linearLayout, false)
            val imageView =  view.findViewById<ImageView>(R.id.iv)
            imageView.setImageResource(images[i])
            val tv = view.findViewById<TextView>(R.id.tv)
            tv.text = brands[i]
            linearLayout?.addView(view)
        }
    }
}