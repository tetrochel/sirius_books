// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get expositions => 'Выставки';

  @override
  String get new_exposition => 'Новая выставка';

  @override
  String get books => 'Книги';

  @override
  String get bookCount => 'Количество книг';

  @override
  String get collections => 'Коллекции';

  @override
  String get collection => 'Коллекция';

  @override
  String get login => 'Войти';

  @override
  String get registration => 'Регистрация';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Пароль';

  @override
  String get forgotPassword => 'Забыли пароль';

  @override
  String get restorePassword => 'Восстановить пароль';

  @override
  String get filter => 'Фильтр';

  @override
  String get repeatPassword => 'Повторите пароль';

  @override
  String get error => 'Ошибка';

  @override
  String get title => 'Название';

  @override
  String get description => 'Описание';

  @override
  String get create => 'Создать';

  @override
  String get startDate => 'Дата начала';

  @override
  String get endDate => 'Дата окончания';

  @override
  String get errorStartDateAfterEndDate =>
      'Дата начала не может быть раньше даты окончания';
}
