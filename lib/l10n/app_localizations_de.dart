// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get exercises => 'Übungen';

  @override
  String get searchHint => 'Suchen';

  @override
  String get trainingsMode => 'Trainingsmodus';

  @override
  String get enterCodeHint => 'Gib deinen Code ein...';

  @override
  String get done => 'Fertig';

  @override
  String get alertSuccess => 'Glückwunsch!';

  @override
  String get alertClose => 'Schließen';

  @override
  String get alertScore => 'Deine Punkte: ';

  @override
  String get rightSheetStart => 'Loslegen';

  @override
  String get rightSheetDetails => 'Details';

  @override
  String get result0 => 'Das Programm ist ohne Output abgestürzt';

  @override
  String get result25 => 'Das Programm hat einen falschen Output geliefert & ist anschließend abgestürzt';

  @override
  String get result50 => 'Das Programm hat den richtigen Output geliefert & ist dann abgestürzt';

  @override
  String get result75 => 'Das Programm lief erfolgreich, aber der Output ist falsch';

  @override
  String get result100 => 'Das Programm lief erfolgreich & lieferte den korrekten Output!';

  @override
  String get settings => 'Einstellungen';

  @override
  String get themeMode => 'Modus des Themas:';

  @override
  String get system => 'System';

  @override
  String get lightMode => 'Hell';

  @override
  String get darkMode => 'Dunkel';

  @override
  String get localisationMode => 'Sprache:';

  @override
  String get localeEnglish => 'Englisch';

  @override
  String get localeGerman => 'Deutsch';
}
