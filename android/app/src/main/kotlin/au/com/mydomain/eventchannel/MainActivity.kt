package au.com.mydomain.eventchannel

import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // We query the system service for the accelerometer.
        val sensorManager: SensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val accelerometerSensor: Sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        // We now set the stream handler for this event channel.
        EventChannel(flutterEngine.dartExecutor, "eventChannelDemo")
            .setStreamHandler(AccelerometerStreamHandler(sensorManager, accelerometerSensor))
    }
}