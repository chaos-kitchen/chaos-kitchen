class AppConfig {
  static String clientIdPrefKey = 'clientId';

  static Uri get apiBaseUri {
    final urlStr = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8000',
    );
    return Uri.parse(urlStr);
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
