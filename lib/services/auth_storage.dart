import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String usersKey = 'users';

  static Future<Map<String, String>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(usersKey) ?? [];

    return {
      for (var item in raw)
        item.split(':')[0]: item.split(':')[1],
    };
  }

  static Future<void> saveUsers(Map<String, String> users) async {
    final prefs = await SharedPreferences.getInstance();
    final list = users.entries.map((e) => '${e.key}:${e.value}').toList();
    await prefs.setStringList(usersKey, list);
  }
}