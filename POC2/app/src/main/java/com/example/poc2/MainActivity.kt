package com.example.poc2;

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.Menu
import android.view.MenuItem
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.activity.result.ActivityResultCallback
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.result.contract.ActivityResultContracts.StartActivityForResult
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController

import androidx.core.app.ActivityCompat
import com.example.poc2.R
import com.example.poc2.SmartHearsBTDevice
import 	android.media.AudioManager
import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import androidx.navigation.findNavController
import com.google.android.material.bottomnavigation.BottomNavigationView

import java.lang.System.exit


class MainActivity : AppCompatActivity() {

    private var btDevice: SmartHearsBTDevice = SmartHearsBTDevice()

    private var requestBluetooth = registerForActivityResult(StartActivityForResult()) { result ->
        if (result.resultCode == RESULT_OK) {
            //granted
        }else{
            exit(0);
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


    private val _batteryLevelRight: MutableLiveData<Int> = MutableLiveData<Int>(0)
    val batteryLevelRight: LiveData<Int> = _batteryLevelRight

    private val _batteryLevelLeft: MutableLiveData<Int> = MutableLiveData<Int>(0)
    val batteryLevelLeft: LiveData<Int> = _batteryLevelLeft

    private val _volumeLevelRight: MutableLiveData<Int> = MutableLiveData<Int>(0)
    val volumeLevelRight: LiveData<Int> = _volumeLevelRight

    private val _volumeLevelLeft: MutableLiveData<Int> = MutableLiveData<Int>(0)
    val volumeLevelLeft: LiveData<Int> = _volumeLevelLeft

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        val layoutInflater = LayoutInflater.from(this)

        val navView: BottomNavigationView = findViewById(R.id.nav_view)

        val navController = findNavController(R.id.nav_host_fragment)
        val appBarConfiguration = AppBarConfiguration(
            setOf(
                R.id.navigation_info, R.id.navigation_scroll
            )
        )
        setupActionBarWithNavController(navController, appBarConfiguration)
        navView.setupWithNavController(navController)

        audioManager = this.getSystemService(AUDIO_SERVICE) as AudioManager
        btDevice.bindAudioManager(audioManager)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            requestMultiplePermissions.launch(
                arrayOf(
                    Manifest.permission.BLUETOOTH_SCAN,
                    Manifest.permission.BLUETOOTH_CONNECT,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                )
            )
        } else {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            requestBluetooth.launch(enableBtIntent)
            requestMultiplePermissions.launch(
                arrayOf(
                    Manifest.permission.BLUETOOTH_SCAN,
                    Manifest.permission.BLUETOOTH_CONNECT,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                )
            )
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
            val audioLeft = findViewById<TextView>(R.id.left)
            val audioRight = findViewById<TextView>(R.id.right)
            Log.d(
                "Debugg",
                "Name -> ${device.name} and Mac address -> ${device.address} and type is ${device.type}"
            )
            if (device.type == 3) { // TODO Voir pour le type... logiquement BluetoothProfile.HEARING_AID mais la comme ca j'en ai pas
                Log.d(
                    "BT Battery",
                    "Battery lvl of your bt device is ${btDevice.getBatteryLevel()}"
                )
                Log.d(
                    "BT Audio",
                    "Current audio level is ${btDevice.getCurrentMediaVolume()}, max is ${
                        btDevice.getMaxMediaVolume()
                    }"
                )
                btDevice.bindBluetoothDevice(device)
                //btDevice.setMediaVolume(audioManager, 5)
                //btDevice.raiseMediaVolume(audioManager)
                //btDevice.lowerMediaVolume(audioManager)

            }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                // Battery and audio level auto MAJ
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            val batteryHandler = Handler(Looper.getMainLooper())

            batteryHandler.post(object : Runnable {
                override fun run() {
                    _batteryLevelLeft.postValue(btDevice.getBatteryLevel())
                    _batteryLevelRight.postValue(btDevice.getBatteryLevel())
                    _volumeLevelLeft.postValue((btDevice.getCurrentMediaVolume().toFloat() / btDevice.getMaxMediaVolume().toFloat() * 100f).toInt())
                    _volumeLevelRight.postValue((btDevice.getCurrentMediaVolume().toFloat() / btDevice.getMaxMediaVolume().toFloat() * 100f).toInt())
                    batteryHandler.postDelayed(this, 1000)
                }
            })

            batteryLevelRight.observe(this, Observer {
                    newValue -> textRight.text = "$newValue%"
            })
            batteryLevelLeft.observe(this, Observer {
                newValue -> textLeft.text = "$newValue%"
            })
            volumeLevelRight.observe(this, Observer {
                    newValue -> audioRight.text = "$newValue%"
            })
            volumeLevelLeft.observe(this, Observer {
                    newValue -> audioLeft.text = "$newValue%"
            })
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        //}
        }
    }
}
