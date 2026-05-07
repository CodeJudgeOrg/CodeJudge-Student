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
import 'package:code_judge/layouts/desktop_layout.dart';
import 'package:code_judge/layouts/mobile_layout.dart';
import 'package:code_judge/layouts/tablet_layout.dart';
import 'package:code_judge/utils/api_connector.dart';
import 'package:code_judge/utils/judger_bindings.dart';
import 'package:code_judge/utils/judger_loader.dart';
import 'package:code_judge/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


late JudgerLib judgerLib;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the library just once and store it global
  final lib = await loadJudgerLibrary();
  judgerLib = JudgerLib(lib);

  final submissionsController = SubmissionProvider();
  final exerciseController = ExerciseProvider();
  final settingsController = SettingsController();

  //Apply SharedPreferences
  await settingsController.loadSettings();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => submissionsController),
        ChangeNotifierProvider(create: (_) => exerciseController),
        ChangeNotifierProvider(create: (_) => settingsController),
      ],
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
  const HomePageLayoutHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final screenType = Responsive.getScreenType(constrains.maxWidth);

        // Receive all exercises
        ApiConnector().receiveExercises(context);

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

