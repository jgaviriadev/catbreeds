import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing local storage using SharedPreferences.
/// 
/// Provides direct access to SharedPreferences instance.
/// Use `prefs` to access all SharedPreferences methods directly.
class SharedPrefsService {
  final SharedPreferences prefs;

  SharedPrefsService(this.prefs);
}
