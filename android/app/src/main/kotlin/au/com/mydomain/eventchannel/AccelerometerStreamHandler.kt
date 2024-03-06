// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package au.com.mydomain.eventchannel

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel

class AccelerometerStreamHandler(sManager: SensorManager, s: Sensor) : EventChannel.StreamHandler, SensorEventListener {
    private val sensorManager: SensorManager = sManager
    private val accelerometerSensor: Sensor = s
    private lateinit var eventSink: EventChannel.EventSink

    // We Override methods from EventChannel.StreamHandler interface.
    // The onListen() callback is called when the stream gets its first subscriber.
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if (events != null) {
            eventSink = events
            sensorManager.registerListener(this, accelerometerSensor, SensorManager.SENSOR_DELAY_UI)
        }
    }

    // The onCancel() callback is called when the controller loses its last subscriber.
    override fun onCancel(arguments: Any?) {
        sensorManager.unregisterListener(this)
    }

    // We Override methods from SensorEventListener interface.

    // Called when the accuracy of the registered sensor has changed - override from SensorEventListener.
    // We are not using this at the moment.
    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    // Called when there is a new sensor event  - override from SensorEventListener.
    override fun onSensorChanged(sensorEvent: SensorEvent?) {
        if (sensorEvent != null) {
            val axisValues = listOf(sensorEvent.values[0], sensorEvent.values[1], sensorEvent.values[2])
            eventSink.success(axisValues)
        } else {
            eventSink.error("DATA_UNAVAILABLE", "Cannot get accelerometer data", null)
        }
    }
}