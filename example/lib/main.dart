import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_projection_plugin/media_projection_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _videoCaptureStarted = false;
  Exception? error;
  final _mediaProjectionPlugin = MediaProjectionPlugin();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> startScreenCapture() async {
    bool started = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final bool? res = await _mediaProjectionPlugin.startScreenCapture();
      started = res ?? false;
    } on PlatformException catch (e) {
      started = false;
      error = e;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _videoCaptureStarted = started;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Video Capture Running: $_videoCaptureStarted'),
              SizedBox(height: 20),
              IconButton(
                onPressed: () async {
                  await startScreenCapture();
                },
                icon: Icon(
                  _videoCaptureStarted ? Icons.pause : Icons.play_arrow,
                ),
              ),
              if (error != null)
                Text(
                  "$error",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
