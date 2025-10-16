import 'package:shared_preferences/shared_preferences.dart';

/// A simple helper class for saving and loading user favorites
/// using SharedPreferences. Keeps your main pages clean.
class FavoritesStorage {
  static const _key = 'favorites';

  /// Load all saved favorites
  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  /// Save an updated list of favorites
  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, favorites);
  }

  /// Add a single new favorite (ignores duplicates)
  static Future<void> addFavorite(String place) async {
    final favorites = await loadFavorites();
    if (!favorites.contains(place)) {
      favorites.add(place);
      await saveFavorites(favorites);
    }
  }

  /// Remove a favorite by name
  static Future<void> removeFavorite(String place) async {
    final favorites = await loadFavorites();
    favorites.remove(place);
    await saveFavorites(favorites);
  }

  /// Clear all saved favorites
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
