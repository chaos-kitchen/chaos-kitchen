import 'dart:async';

import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController {
  final Uri url;

  late final WebSocketSink _sink;
  late final Stream<ServerToClientMessage> stream;

  WebSocketController(this.url);

  Future<void> initialize() async {
    final channel = WebSocketChannel.connect(url);

    _sink = channel.sink;
    stream = channel.stream
        .map((message) => message as List<int>)
        .map((message) => ServerToClientMessage.fromBuffer(message));
  }

  void sendMessage(ClientToServerMessage message) {
    _sink.add(message.writeToBuffer());
  }

  void dispose() {
    _sink.close();
  }
}
