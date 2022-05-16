package com.example.poc2


import android.bluetooth.BluetoothDevice
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class BatteryViewModel : ViewModel() {

    private val _batteryLevel: MutableLiveData<Int> by lazy {
        MutableLiveData<Int>().also {
            0
        }
    }

    val batteryLevel: LiveData<Int> = _batteryLevel

}
