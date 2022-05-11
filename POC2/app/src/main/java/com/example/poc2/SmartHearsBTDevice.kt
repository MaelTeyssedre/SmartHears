package com.example.poc2

import android.bluetooth.BluetoothDevice
import android.media.AudioManager
import android.content.Context
import android.os.Bundle
import android.widget.Toast
import java.util.*

class SmartHearsBTDevice {

    fun getBatteryLevel(pairedDevice: BluetoothDevice?): Int {
        return pairedDevice?.let { bluetoothDevice ->
            (bluetoothDevice.javaClass.getMethod("getBatteryLevel"))
                .invoke(pairedDevice) as Int
        } ?: -1
    }

    fun setMediaVolume(audioManager : AudioManager, volumeIndex:Int) {
        // Set media volume level
        audioManager.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            volumeIndex, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
        )
    }

    fun raiseMediaVolume(audioManager : AudioManager) {
        audioManager.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            audioManager.getStreamVolume(AudioManager.STREAM_MUSIC) + 1, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
        )
    }

    fun lowerMediaVolume(audioManager : AudioManager) {
        audioManager.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            audioManager.getStreamVolume(AudioManager.STREAM_MUSIC) - 1, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
        )
    }

    fun getCurrentMediaVolume(audioManager : AudioManager): Int {
        return audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
    }

    fun getMaxMediaVolume(audioManager : AudioManager): Int {
        return audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
    }
}