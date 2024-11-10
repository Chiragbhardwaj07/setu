import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? _socket;
  String? recognizedText;

  // Add a callback to notify when recognized text is received
  void Function(String)? onRecognizedText;

  // Initialize and connect the socket
  void connect(String serverUrl) {
    _socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Only WebSocket is used for transport
          .enableAutoConnect()
          .build(),
    );

    // Handle connection event
    _socket!.onConnect((_) {
      print("Connected to server");
    });

    // Handle disconnection
    _socket!.onDisconnect((_) {
      print("Disconnected from server");
    });

    // Listen for recognized text and call the callback if set
    _socket!.on('recognized_text', (data) {
      recognizedText = data['text'];
      if (onRecognizedText != null) {
        onRecognizedText!(recognizedText ?? "No text recognized");
      }
      print("Received text: $recognizedText");
    });

    // Listen for errors
    _socket!.on('error', (data) {
      String errorMsg = data['message'] ?? "Unknown error";
      print("Server error: $errorMsg");
    });
  }

  // Disconnect the socket
  void disconnect() {
    _socket?.disconnect();
  }

  // Send an image to the server for processing
  void submitFrame(String base64Image) {
    if (_socket == null || !_socket!.connected) {
      print("Not connected to server");
      return;
    }

    _socket!.emit('submit_frame', {'image': base64Image});
  }
}
