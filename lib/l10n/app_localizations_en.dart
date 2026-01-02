// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get exercises => 'Exercises';

  @override
  String get searchHint => 'Search';

  @override
  String get trainingsMode => 'Trainings mode';

  @override
  String get enterCodeHint => 'Enter your code...';

  @override
  String get done => 'Done';

  @override
  String get alertSuccess => 'Congratulations!';

  @override
  String get alertClose => 'Close';

  @override
  String get alertScore => 'Your score: ';

  @override
  String get rightSheetStart => 'Start';

  @override
  String get rightSheetDetails => 'Details';

  @override
  String get result0 => 'The programm crashed without an output';

  @override
  String get result25 => 'The programm returned a wrong output & crashed then';

  @override
  String get result50 => 'The programm returned the correct output & crashed afterwards';

  @override
  String get result75 => 'The programm ran successfully, but the output was wrong';

  @override
  String get result100 => 'The programm ran successfulle & the output was correct as well!';

  @override
  String get settings => 'Settings';

  @override
  String get themeMode => 'Theme Mode:';

  @override
  String get system => 'System';

  @override
  String get lightMode => 'Light';

  @override
  String get darkMode => 'Dark';

  @override
  String get localisationMode => 'Language:';

  @override
  String get localeEnglish => 'English';

  @override
  String get localeGerman => 'German';
}
