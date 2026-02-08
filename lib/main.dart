/// Copyright 2026 Fabian Roland (naibaf-1)

/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at

/// http://www.apache.org/licenses/LICENSE-2.0

/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:code_judge/l10n/app_localizations.dart';
import 'package:code_judge/layouts/DesktopLayout.dart';
import 'package:code_judge/layouts/MobileLayout.dart';
import 'package:code_judge/layouts/TabletLayout.dart';
import 'package:code_judge/utils/judger_bindings.dart';
import 'package:code_judge/utils/judger_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


late JudgerLib judgerLib;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the library just once and store it global
  final lib = await loadJudgerLibrary();
  judgerLib = JudgerLib(lib);

  final settingsController = SettingsController();
  //Apply SharedPreferences
  await settingsController.loadSettings();
  runApp(
    ChangeNotifierProvider(
      create: (_) => settingsController,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime, brightness: Brightness.light),
      useMaterial3: true,
    );
    final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime, brightness: Brightness.dark),
      useMaterial3: true,
    );

    // Apply the correct theme to the whole app
    return MaterialApp(
      title: 'CodeJudge',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settingsController.selectedTheme,

      // Apply the correct language to the app
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('de')],
      locale: settingsController.selectedLocale,

      // Widget shown when the app launches
      home: HomePageLayoutHandler(),
    );
  }
}

// Decide for the correct layout depending on the screen type
class HomePageLayoutHandler extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final screenType = Responsive.getScreenType(constrains.maxWidth);
      
        // Use the correct layout depending on the screensize
        switch (screenType) {
          // User is supposed to use a desktop
          case ScreenType.desktop:
            return Desktoplayout();
          // Tablet would be fine too
          case ScreenType.tablet:
            return Tabletlayout();
          // Mobile devices are probably useless
          case ScreenType.mobile:
            return Mobilelayout();
        }
      },
    );
  }
}

// Define the screen types
enum ScreenType {mobile, tablet, desktop}
// Apply the correct screen type
class Responsive{
    static ScreenType getScreenType (double width) {
    // For desktops
    if (width >= 1200) {
      return ScreenType.desktop;
    }
    // For tablets
    if (width >= 900) {
      return ScreenType.tablet;
    }
    // Else it's a mobile phone
    return ScreenType.mobile;
  }
}

// Apply the settings to the whole app
class SettingsController extends ChangeNotifier {
  ThemeMode _selectedTheme = ThemeMode.system;
  ThemeMode get selectedTheme => _selectedTheme;
  Locale? _selectedLocale;
  Locale? get selectedLocale => _selectedLocale;
  
  // Get the applied settings from the preferences
  Future<void> loadSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final localeCode = sharedPreferences.getString('selected_locale');
    final themeCode = sharedPreferences.getString('selected_theme');

    // Set correct localisation
    if (localeCode != null) {
      _selectedLocale = Locale(localeCode);
    } else {
      _selectedLocale = null; // System language
    }
    // Set correct theme
    if (themeCode == "light") {
      _selectedTheme = ThemeMode.light;
    } else if (themeCode == "dark") {
      _selectedTheme = ThemeMode.dark;
    } else {
      _selectedTheme = ThemeMode.system;
    }
    notifyListeners();
  }

  // Apply correct theme
  Future<void> applyTheme(ThemeMode mode) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (mode == ThemeMode.system) {
      await sharedPreferences.remove('selected_theme');
    } else if (mode == ThemeMode.light){
      await sharedPreferences.setString('selected_theme', 'light');
    } else {
      await sharedPreferences.setString('selected_theme', 'dark');
    }
    _selectedTheme = mode;
    notifyListeners();
  }

  // Apply the correct language
  Future<void> applyLanguage(Locale? locale) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (locale == null) {
      await sharedPreferences.remove('selected_locale');
      _selectedLocale = null;
    } else {
      await sharedPreferences.setString('selected_locale', locale.languageCode);
      _selectedLocale = locale;
    }
    notifyListeners();
  }
}
