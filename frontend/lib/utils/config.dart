import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AppConfig {
  static const String clientIdPrefKey = 'clientId';
  static const String playerNamePrefKey = 'playerName';

  static const bool showDebugCollisionBoxes = true;
  static const bool showDebugJoinGameButton = true;

  static Uri? _apiBaseUriCached;
  static Future<Uri> getApiBaseUri() async {
    if (_apiBaseUriCached != null) {
      return _apiBaseUriCached!;
    }
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;

    final urlStr = String.fromEnvironment('API_BASE_URL');
    if (urlStr.isNotEmpty) {
      var baseUri = Uri.parse(urlStr);
      _apiBaseUriCached = baseUri;
      return baseUri;
    }

    if (Platform.isAndroid && !androidInfo.isPhysicalDevice) {
      var baseUri = Uri.parse('http://10.0.2.2:8000');
      _apiBaseUriCached = baseUri;
      return baseUri;
    }

    var baseUri = Uri.parse('http://localhost:8000');
    _apiBaseUriCached = baseUri;
    return baseUri;
  }

  static Future<Uri> getLobbyWebSocketUri({
    required String lobbyRoomId,
    required String clientId,
    required String playerName,
  }) async {
    final apiBaseUri = await getApiBaseUri();
    final wsUrl = Uri(
      scheme: apiBaseUri.scheme == 'https' ? 'wss' : 'ws',
      host: apiBaseUri.host,
      port: apiBaseUri.port,
      path: '/ws/lobby/$lobbyRoomId/$clientId',
      queryParameters: {"player_name": playerName},
    );
    return wsUrl;
  }

  static Future<Uri> getGameWebSocketUri({
    required String gameRoomId,
    required String clientId,
    required String playerName,
  }) async {
    final apiBaseUri = await getApiBaseUri();
    final wsUrl = Uri(
      scheme: apiBaseUri.scheme == 'https' ? 'wss' : 'ws',
      host: apiBaseUri.host,
      port: apiBaseUri.port,
      path: '/ws/game/$gameRoomId/$clientId',
    );
    return wsUrl;
  }
}
