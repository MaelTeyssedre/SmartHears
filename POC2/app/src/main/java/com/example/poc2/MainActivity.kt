package com.example.poc2;
import android.Manifest
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import android.util.Log
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.content.pm.PackageManager
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.example.poc2.R
import com.example.poc2.SmartHearsBTDevice
import 	android.media.AudioManager
import android.content.Context

class MainActivity : AppCompatActivity() {

    private var battery: Int = 100
    private var linearLayout: LinearLayout? = null
    private var btDevice: SmartHearsBTDevice = SmartHearsBTDevice()
    private val brands = arrayOf("Battery", "Camera", "Email", "Location", "Music", "Password",
        "Phone", "Storage" , "Tablet", "Time")
    private val images = intArrayOf(
        R.drawable.battery, R.drawable.camera, R.drawable.email,
        R.drawable.location, R.drawable.music, R.drawable.password, R.drawable.phone,
        R.drawable.storage, R.drawable.tablet, R.drawable.time)
    private lateinit var audioManager: AudioManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        linearLayout = findViewById(R.id.linear1)
        val layoutInflater = LayoutInflater.from(this)

        audioManager = this.getSystemService(Context.AUDIO_SERVICE) as AudioManager

        for (i in brands.indices)
        {
            val view: View = layoutInflater.inflate(R.layout.test, linearLayout, false)
            val imageView =  view.findViewById<ImageView>(R.id.iv)
            imageView.setImageResource(images[i])
            val tv = view.findViewById<TextView>(R.id.tv)
            tv.text = brands[i]
            linearLayout?.addView(view)
        }
        val btManager = getSystemService(BLUETOOTH_SERVICE) as BluetoothManager
        /*if (ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT)
            != PackageManager.PERMISSION_GRANTED ) {
            return
        }
         */
        val connectedDevices = btManager.getConnectedDevices(BluetoothProfile.GATT)
        connectedDevices?.forEach { device ->
            val deviceName = device.name
            val deviceHardwareAddress = device.address // MAC address
            val deviceType = device.type // Device Type
            val textLeft = findViewById<TextView>(R.id.textView)
            val textRight = findViewById<TextView>(R.id.textView4)
            Log.d ("Debugg", "Name -> ${device.name} and Mac address -> ${device.address} and type is ${device.type}")
            if (device.type == 3) { // TODO Voir pour le type... logiquement BluetoothProfile.HEARING_AID mais la comme ca j'en ai pas
                Log.d("BT Battery", "Battery lvl of your bt device is ${btDevice.getBatteryLevel(device)}")
                Log.d("BT Audio", "Current audio level is ${btDevice.getCurrentMediaVolume(audioManager)}, max is ${btDevice.getMaxMediaVolume(audioManager)}")
                battery = btDevice.getBatteryLevel(device)
                //btDevice.setMediaVolume(audioManager, 5)
                //btDevice.raiseMediaVolume(audioManager)
                //btDevice.lowerMediaVolume(audioManager)
            }
            textLeft.text = "$battery%"
            textRight.text = "$battery%"
        }
    }
}
