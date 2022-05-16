package com.example.poc2

import android.bluetooth.BluetoothDevice
import android.media.AudioManager
import android.content.Context
import android.os.Bundle
import android.widget.Toast
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import java.util.*

class SmartHearsBTDevice {

    private lateinit var _audioManager: AudioManager
    private var _btDevice: BluetoothDevice? = null

    fun bindAudioManager(audioManager: AudioManager) {
        _audioManager = audioManager
    }

    fun bindBluetoothDevice(btDevice: BluetoothDevice?) {
        _btDevice = btDevice
    }

    fun getBatteryLevel(): Int {
        return _btDevice?.let { bluetoothDevice ->
            (bluetoothDevice.javaClass.getMethod("getBatteryLevel"))
                .invoke(_btDevice) as Int
        } ?: -1
    }

    fun setMediaVolume(volumeIndex:Int) {
        // Set media volume level
        _audioManager.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            volumeIndex, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
        )
    }

    fun raiseMediaVolume() {
        _audioManager.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            _audioManager.getStreamVolume(AudioManager.STREAM_MUSIC) + 1, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
        )
    }

    fun lowerMediaVolume() {
        _audioManager.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            _audioManager.getStreamVolume(AudioManager.STREAM_MUSIC) - 1, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
        )
    }

    fun getCurrentMediaVolume(): Int {
        return _audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
    }

    fun getMaxMediaVolume(): Int {
        return _audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
    }
}