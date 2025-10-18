// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get example_text => 'Example text in English';

  @override
  String get home_route_name => 'Home';

  @override
  String get tasks_route_name => 'Tasks';

  @override
  String get task_details_route_name => 'Task Details';

  @override
  String get tasks_page_title => 'My Tasks';

  @override
  String task_with_id(Object id) {
    return 'Task $id';
  }

  @override
  String task_description_with_id(Object id) {
    return 'Description of task with id $id';
  }

  @override
  String task_detail_page_with_id(Object id) {
    return 'Task Detail Page with ID: $id';
  }

  @override
  String task_detail_page_error_with_id(Object id) {
    return 'Error loading task details with ID: $id';
  }

  @override
  String get setting_theme => 'Change Theme';

  @override
  String get setting_theme_system => 'System';

  @override
  String get setting_language => 'Change Language';

  @override
  String get setting_language_dialog_input_hint => 'Search language...';

  @override
  String get setting_language_dialog_close_button => 'Close';
}
