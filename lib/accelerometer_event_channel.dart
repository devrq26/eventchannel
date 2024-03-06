// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';

/// This class holds data on the information we receive from
/// the accelerometer sensor, viz, three double values
/// giving us the acceleration along the three
/// axes x,y & z.
class AccelerometerReadings {
  /// Acceleration along the x-axis.
  final double x;

  /// Acceleration along the y-axis.
  final double y;

  /// Acceleration along the z-axis.
  final double z;

  AccelerometerReadings(this.x, this.y, this.z);
}


/// This class includes the implementation for [EventChannel]
/// to listen to value changes from the Accelerometer
/// sensor from the native side. It has a [readings]
/// getter to provide a stream of [AccelerometerReadings].
class Accelerometer {
  // Event channel name.
  static const _eventChannel = EventChannel('eventChannelDemo');

  /// Method responsible for providing a stream of
  /// [AccelerometerReadings] to listen
  /// to value changes from the Accelerometer sensor.
  static Stream<AccelerometerReadings> get readings {
    return _eventChannel.receiveBroadcastStream().map(
          (dynamic event) => AccelerometerReadings(
        event[0] as double,
        event[1] as double,
        event[2] as double,
      ),
    );
  }
}

