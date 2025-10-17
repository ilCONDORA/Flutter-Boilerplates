// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get languageName => 'Italiano';

  @override
  String get example_text => 'Testo di esempio in italiano';

  @override
  String get tasks_page_title => 'Le Mie Attività';

  @override
  String task_with_id(Object id) {
    return 'Attività $id';
  }

  @override
  String task_description_with_id(Object id) {
    return 'Descrizione dell\'attività con id $id';
  }

  @override
  String task_detail_page_with_id(Object id) {
    return 'Pagina Dettagli Attività con ID: $id';
  }

  @override
  String task_detail_page_error_with_id(Object id) {
    return 'Errore nel caricare i dettagli dell\'attività con ID: $id';
  }

  @override
  String get setting_theme => 'Cambia Tema';

  @override
  String get setting_theme_system => 'Sistema';

  @override
  String get setting_language => 'Cambia Lingua';

  @override
  String get setting_language_dialog_input_hint => 'Cerca lingua...';

  @override
  String get setting_language_dialog_close_button => 'Chiudi';
}
