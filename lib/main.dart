import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './accelerometer_event_channel.dart';

void main() {
  // Need to wrap our stateless widget in a MaterialApp
  // otherwise our App will blow up.
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventChannel Demo'),
      ),
      body: Center(
        // We use StreamBuilder in a stateless widget
        // because internally StreamBuilder is a stateful
        // widget and uses setState() as required depending
        // on stream updates received.
        child: StreamBuilder<AccelerometerReadings>(
            stream: Accelerometer.readings,
            builder: (BuildContext context,
                AsyncSnapshot<AccelerometerReadings> snapshot) {
              if (snapshot.hasError) {
                return (Text((snapshot.error as PlatformException).message!));
              } else if (!snapshot.hasData) {
                return (Text('No Data Available', style: textStyle));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the accelerometer data.
                    Text('x axis: ${snapshot.data!.x.toStringAsFixed(3)}',
                        style: textStyle),
                    Text('y axis: ${snapshot.data!.y.toStringAsFixed(3)}',
                        style: textStyle),
                    Text('z axis: ${snapshot.data!.z.toStringAsFixed(3)}',
                        style: textStyle)
                  ],
                );
              }
            }
        ),
      ),
    );
  }
}
