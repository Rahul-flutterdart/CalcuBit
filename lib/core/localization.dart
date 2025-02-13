// localization.dart
import 'dart:ui';

import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'welcome': 'Welcome',
      'login': 'Login',
      'add_expense': 'Add Expense',
      'expense_summary': 'Expense Summary',
    },
    'hi_IN': {
      'welcome': 'स्वागत है',
      'login': 'लॉग इन करें',
      'add_expense': 'खर्च जोड़ें',
      'expense_summary': 'खर्च सारांश',
    },
  };
}

void changeLanguage(String langCode) {
  var locale = Locale(langCode);
  Get.updateLocale(locale);
}
