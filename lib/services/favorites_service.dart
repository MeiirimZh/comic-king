import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _key = 'favorite_characters';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<bool> addToFavorites(String characterId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];

    if (favorites.contains(characterId)) {
      return false;
    }

    favorites.add(characterId);
    await prefs.setStringList(_key, favorites);
    return true;
  }

  static Future<bool> isFavorite(String characterId) async {
    final favorites = await getFavorites();
    return favorites.contains(characterId);
  }
}
