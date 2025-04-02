// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get expositions => 'Expositions';

  @override
  String get new_exposition => 'New exposition';

  @override
  String get books => 'Books';

  @override
  String get collections => 'Collections';

  @override
  String get collection => 'Collection';

  @override
  String get login => 'Login';

  @override
  String get registration => 'Registration';

  @override
  String get signUp => 'Sign Up';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Password';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String get error => 'Error';

  @override
  String get title => 'Title';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'End date';

  @override
  String get errorStartDateAfterEndDate => 'The start date cannot be earlier than the end date';
}
