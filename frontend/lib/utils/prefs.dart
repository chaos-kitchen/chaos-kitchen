import 'package:chaos_kitchen/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Future<String> getClientIdFromPrefs() async {
  final asyncPrefs = SharedPreferencesAsync();
  var clientId = await asyncPrefs.getString(AppConfig.clientIdPrefKey);

  if (clientId == null) {
    clientId = const Uuid().v4();
    await asyncPrefs.setString(AppConfig.clientIdPrefKey, clientId);
  }

  return clientId;
}

Future<String> getPlayerNameFromPrefs() async {
  final asyncPrefs = SharedPreferencesAsync();
  var playerName = await asyncPrefs.getString(AppConfig.playerNamePrefKey);
  if (playerName == null) {
    return '';
  }
  return playerName;
}

Future<void> setPlayerNameInPrefs(String playerName) async {
  final asyncPrefs = SharedPreferencesAsync();
  await asyncPrefs.setString(AppConfig.playerNamePrefKey, playerName);
}
