import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'socket_service.dart';

class SocketApp extends StatefulWidget {
  @override
  _SocketAppState createState() => _SocketAppState();
}

class _SocketAppState extends State<SocketApp> {
  final SocketService _socketService = SocketService();
  String _recognizedText = "Awaiting text...";

  @override
  void initState() {
    super.initState();

    // Set the callback to update _recognizedText
    _socketService.onRecognizedText = (String text) {
      setState(() {
        _recognizedText = text;
      });
    };

    _socketService.connect('http://192.168.0.171:8000');
  }

  // Convert an image to base64
  String imageToBase64(Uint8List imageBytes) {
    return base64Encode(imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket.IO Flutter Client"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Example of sending a frame (replace with actual image processing)
                String sampleBase64Image = imageToBase64(Uint8List(0)); // Use actual image bytes
                _socketService.submitFrame(sampleBase64Image);
              },
              child: Text("Send Frame"),
            ),
            SizedBox(height: 20),
            Text("Recognized Text: $_recognizedText"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }
}
