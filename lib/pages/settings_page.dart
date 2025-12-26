import 'package:code_juge/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:orderty_customer/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final themeFocusNode = FocusNode();
    final settingsController = Provider.of<SettingsController>(context);
    final currentMode = settingsController.selectedTheme;
    final currentLocalization = settingsController.selectedLocale?.languageCode ?? 'system';
    // TODO Get translation
    //final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("appLocalizations.settings"),
        backgroundColor: theme.colorScheme.primaryContainer,
      ), //Title: Settings
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("appLocalizations.themeMode"), // Theme Mode:
              trailing: SizedBox(
                width: 86,
                child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  focusNode: themeFocusNode,
                  value: currentMode,
                  onChanged: (mode) {
                    settingsController.applyTheme(mode!);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text("appLocalizations.system")  // System
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text("appLocalizations.lightMode") // Light
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text("appLocalizations.darkMode") // Dark
                    ),
                  ],
                ),
                ),
              ),
            ),
            ListTile(
              title: Text("appLocalizations.localisationMode"), // Language:
              trailing: SizedBox(
                width: 86,
                child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusNode: themeFocusNode,
                  value: currentLocalization,
                  onChanged: (value) {
                      if (value == 'system') {
                        settingsController.applyLanguage(null);
                      } else {
                        settingsController.applyLanguage(Locale(value!));
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  items: [
                      DropdownMenuItem(
                        value: 'system',
                        child: Text("appLocalizations.system"), // System
                      ),
                      DropdownMenuItem(
                        value: 'en',
                        child: Text("appLocalizations.localeEnglish"), // English
                      ),
                      DropdownMenuItem(
                        value: 'de',
                        child: Text("appLocalizations.localeGerman"), // German
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}