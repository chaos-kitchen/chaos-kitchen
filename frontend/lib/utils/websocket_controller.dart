import 'dart:async';

import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController {
  final String roomId;

  late final WebSocketSink _sink;
  late final Stream<ServerToClientMessage> stream;

  WebSocketController({required this.roomId});

  Future<void> initialize() async {
    final clientId = await AppConfig.getClientUuidFromStorage();
    final wsUrl = AppConfig.getWebSocketUri(roomId: roomId, clientId: clientId);

    final channel = WebSocketChannel.connect(wsUrl);

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
