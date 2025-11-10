import 'dart:io';

class AppConfig {
  static String clientIdPrefKey = 'clientId';

  static Uri get apiBaseUri {
    final urlStr = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8000',
    );
    final uri = Uri.parse(urlStr);

    // On Android emulators, localhost refers to the emulator, not the host
    if (uri.host == 'localhost' && Platform.isAndroid) {
      return uri.replace(host: '10.0.2.2');
    }

    return uri;
  }

  static Uri getLobbyWebSocketUri({
    required String lobbyRoomId,
    required String clientId,
    required String playerName,
  }) {
    final wsUrl = Uri(
      scheme: apiBaseUri.scheme == 'https' ? 'wss' : 'ws',
      host: apiBaseUri.host,
      port: apiBaseUri.port,
      path: '/ws/lobby/$lobbyRoomId/$clientId',
      queryParameters: {"player_name": playerName},
    );
    return wsUrl;
  }

  static Uri getGameWebSocketUri({
    required String gameRoomId,
    required String clientId,
    required String playerName,
  }) {
    final wsUrl = Uri(
      scheme: apiBaseUri.scheme == 'https' ? 'wss' : 'ws',
      host: apiBaseUri.host,
      port: apiBaseUri.port,
      path: '/ws/game/$gameRoomId/$clientId',
    );
    return wsUrl;
  }
}
