import 'dart:async';
import 'dart:io';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Allows a stream to be listened to multiple times.
///
/// Returns a new stream which has the same events as [source],
/// but which can be listened to more than once.
/// Only allows one listener at a time, but when a listener
/// cancels, another can start listening and take over the stream.
///
/// If the [source] is a broadcast stream, the listener on
/// the source is cancelled while there is no listener on the
/// returned stream.
/// If the [source] is not a broadcast stream, the subscription
/// on the source stream is maintained, but paused, while there
/// is no listener on the returned stream.
///
/// Only listens on the [source] stream when the returned stream
/// is listened to.
///
/// Source - https://stackoverflow.com/a/70563131
/// Posted by lrn, modified by community.
/// Retrieved 2025-11-26, License - CC BY-SA 4.0
Stream<T> resubscribeStream<T>(Stream<T> source) {
  MultiStreamController<T>? current;
  StreamSubscription<T>? sourceSubscription;
  bool isDone = false;
  void add(T value) {
    current!.addSync(value);
  }

  void addError(Object error, StackTrace stack) {
    current!.addErrorSync(error, stack);
  }

  void close() {
    isDone = true;
    current!.close();
    current = null;
    sourceSubscription = null;
  }

  return Stream<T>.multi((controller) {
    if (isDone) {
      controller.close(); // Or throw StateError("Stream has ended");
      return;
    }
    if (current != null) throw StateError("Has listener");
    current = controller;
    var subscription = sourceSubscription ??= source.listen(
      add,
      onError: addError,
      onDone: close,
    );
    subscription.resume();
    controller
      ..onPause = subscription.pause
      ..onResume = subscription.resume
      ..onCancel = () {
        current = null;
        if (source.isBroadcast) {
          sourceSubscription = null;
          return subscription.cancel();
        }
        subscription.pause();
        return null;
      };
  });
}

class WebSocketController {
  static const Duration reconnectDelay = Duration(seconds: 3);
  static const int maxReconnectAttempts = 5;
  static const Duration pingInterval = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 10);

  final Uri uri;

  // Used to ensure only one webhook listener is active at a time
  Future<void> lock = Future.value();

  IOWebSocketChannel? _channel;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _isDisposed = false;
  bool _hasFatalError = false;

  late final StreamController<ServerToClientMessage> _messageController;
  late final Stream<ServerToClientMessage> stream;

  WebSocketController(this.uri) {
    _messageController = StreamController<ServerToClientMessage>();
    stream = resubscribeStream(_messageController.stream);
  }

  /// Connect to the WebSocket server
  Future<void> connect() async {
    if (_isDisposed) {
      throw StateError('WebSocketController has been disposed');
    }

    var channel = IOWebSocketChannel.connect(
      uri,
      pingInterval: pingInterval,
      connectTimeout: connectTimeout,
    );
    _channel = channel;

    // Listen to the WebSocket stream
    channel.stream.listen(
      (message) {
        final serverMessage = ServerToClientMessage.fromBuffer(message);
        _messageController.add(serverMessage);
        _reconnectAttempts = 0;
      },
      onError: (error) {
        if (_isDisposed) return;

        if (error is! WebSocketChannelException || error.inner is! Exception) {
          print('Unexpected websocket error: $error');
          return;
        }
        var exception = error.inner;
        _messageController.addError(exception!);

        if (exception is WebSocketException) {
          _hasFatalError = true;
        }
      },
      onDone: () {
        print('WebSocket connection closed');

        if (_isDisposed) return;
        if (_hasFatalError) return;
        // Normal closure, do not attempt to reconnect
        if (channel.closeCode == 1000) return;

        _handleDisconnection();
      },
      cancelOnError: false,
    );

    try {
      await channel.ready;
      print('WebSocket connected.');
    } on WebSocketChannelException catch (e) {
      // error already handled in onError listener
    }
  }

  /// Send a message through the WebSocket
  void send(ClientToServerMessage message) {
    if (_channel == null) {
      throw StateError('WebSocket is not connected');
    }
    final data = message.writeToBuffer();
    _channel!.sink.add(data);
  }

  /// Handle disconnection and decide whether to reconnect
  void _handleDisconnection() {
    if (_reconnectAttempts >= maxReconnectAttempts) {
      print('Max reconnect attempts reached. Giving up.');
      _messageController.addError(
        StateError('Failed to reconnect after $maxReconnectAttempts attempts'),
      );
      return;
    }

    print('Attempting to reconnect... (Attempt ${_reconnectAttempts + 1})');
    _reconnectAttempts++;
    _reconnectTimer = Timer(reconnectDelay, () {
      connect();
    });
  }

  /// Dispose of the controller and clean up resources
  Future<void> dispose() async {
    _isDisposed = true;
    _reconnectTimer?.cancel();
    await _channel?.sink.close();
    await _messageController.close();
    _channel = null;
  }
}
