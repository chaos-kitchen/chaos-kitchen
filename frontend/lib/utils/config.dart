import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppConfig {
  static Uri get apiBaseUri {
    final urlStr = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8000',
    );
    return Uri.parse(urlStr);
  }

  static Uri getWebSocketUri({
    required String roomId,
    required String clientId,
  }) {
    final wsUrl = Uri(
      scheme: apiBaseUri.scheme == 'https' ? 'wss' : 'ws',
      host: apiBaseUri.host,
      port: apiBaseUri.port,
      path: '/ws/$roomId/$clientId',
    );
    return wsUrl;
  }

  static Future<String> getClientUuidFromStorage() async {
    final asyncPrefs = SharedPreferencesAsync();
    final String? clientUuid = await asyncPrefs.getString('clientUuid');

    if (clientUuid != null) {
      return clientUuid;
    }

    final newClientUuid = const Uuid().v4();
    await asyncPrefs.setString('clientUuid', newClientUuid);
    return newClientUuid;
  }
}
