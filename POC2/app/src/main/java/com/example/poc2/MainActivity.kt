package com.example.poc2;

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.activity.result.ActivityResultCallback
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.result.contract.ActivityResultContracts.StartActivityForResult
import androidx.appcompat.app.AppCompatActivity

import androidx.core.app.ActivityCompat
import com.example.poc2.R
import com.example.poc2.SmartHearsBTDevice
import 	android.media.AudioManager
import android.content.Context

import java.lang.System.exit


private const val REQUEST_ENABLE_BT = 1
class MainActivity : AppCompatActivity() {

    private var battery: Int = 100
    private var linearLayout: LinearLayout? = null
    private var btDevice: SmartHearsBTDevice = SmartHearsBTDevice()
    private var requestBluetooth = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == RESULT_OK) {
            //granted
        }else{
            //deny
        }
    }

    private val requestMultiplePermissions =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
            permissions.entries.forEach {
                Log.d("test006", "${it.key} = ${it.value}")
            }
        }

    private val brands = arrayOf(
        "Battery", "Camera", "Email", "Location", "Music", "Password",
        "Phone", "Storage", "Tablet", "Time"
    )
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

        for (i in brands.indices) {
            val view: View = layoutInflater.inflate(R.layout.test, linearLayout, false)
            val imageView = view.findViewById<ImageView>(R.id.iv)
            imageView.setImageResource(images[i])
            val tv = view.findViewById<TextView>(R.id.tv)
            tv.text = brands[i]
            linearLayout?.addView(view)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            requestMultiplePermissions.launch(
                arrayOf(
                    Manifest.permission.BLUETOOTH_SCAN,
                    Manifest.permission.BLUETOOTH_CONNECT
                )
            )
        } else {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            requestBluetooth.launch(enableBtIntent)
        }

        /*
        var resultLauncher = registerForActivityResult(StartActivityForResult()) { result ->
            if (result.resultCode == Activity.RESULT_OK) {
                // There are no request codes
                val data: Intent? = result.data
            }
        */


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
            Log.d(
                "Debugg",
                "Name -> ${device.name} and Mac address -> ${device.address} and type is ${device.type}"
            )
            if (device.type == 3) { // TODO Voir pour le type... logiquement BluetoothProfile.HEARING_AID mais la comme ca j'en ai pas
                Log.d(
                    "BT Battery",
                    "Battery lvl of your bt device is ${btDevice.getBatteryLevel(device)}"
                )
                Log.d(
                    "BT Audio",
                    "Current audio level is ${btDevice.getCurrentMediaVolume(audioManager)}, max is ${
                        btDevice.getMaxMediaVolume(audioManager)
                    }"
                )
                battery = btDevice.getBatteryLevel(device)
                //btDevice.setMediaVolume(audioManager, 5)
                //btDevice.raiseMediaVolume(audioManager)
                //btDevice.lowerMediaVolume(audioManager)

            }

            textLeft.text = "$battery%"
            textRight.text = "$battery%"
        //}
        }
    }
}
