import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  //var to save state of the theme
  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

  bool _loadThemFromBox() => _box.read<bool>(_key) ?? false;

  _saveThemToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  ThemeMode get theme => _loadThemFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemFromBox()?ThemeMode.light : ThemeMode.dark);
    _saveThemToBox(!_loadThemFromBox());
  }
}
