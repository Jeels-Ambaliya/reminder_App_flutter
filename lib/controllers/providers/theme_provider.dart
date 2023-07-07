import 'package:flutter/cupertino.dart';

import '../../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModal = ThemeModel(isDark: false);

  changeTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
