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
