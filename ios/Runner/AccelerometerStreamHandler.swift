// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import CoreMotion

class AccelerometerStreamHandler: NSObject, FlutterStreamHandler {

    var motionManager: CMMotionManager;

    override init() {
        motionManager = CMMotionManager()
    }

    // The onListen() callback is called when the stream gets its first subscriber.
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {

        // Accelerometer is not available on simulators.
        if !motionManager.isAccelerometerAvailable {
            events(FlutterError(code: "SENSOR_UNAVAILABLE", message: "Accelerometer is not available", details: nil))
        }

        motionManager.accelerometerUpdateInterval = 0.1

        // Starts accelerometer updates, providing data to the given handler
        // through the given queue.
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) {(data, error) in
            guard let accelerationData = data?.acceleration else {
                events(FlutterError(code: "DATA_UNAVAILABLE", message: "Cannot get accelerometer data", details: nil ))
                return
            }
            
            // Acceleratometer data passed to event sink.
            events([accelerationData.x, accelerationData.y, accelerationData.z])
        }

        return nil
    }

    // The onCancel() callback is called when the controller loses its last subscriber.
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
