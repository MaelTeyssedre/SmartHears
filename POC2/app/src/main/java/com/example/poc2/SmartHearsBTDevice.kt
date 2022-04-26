package com.example.poc2

import android.bluetooth.BluetoothDevice

class SmartHearsBTDevice {

    fun getBatteryLevel(pairedDevice: BluetoothDevice?): Int {
        return pairedDevice?.let { bluetoothDevice ->
            (bluetoothDevice.javaClass.getMethod("getBatteryLevel"))
                .invoke(pairedDevice) as Int
        } ?: -1
    }

}