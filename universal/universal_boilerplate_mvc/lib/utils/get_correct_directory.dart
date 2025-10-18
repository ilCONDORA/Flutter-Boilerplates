import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// This method returns the correct path depending on the platform.
/// It's powered by the path_provider package, here's all the paths it can return:
/// - Android: getApplicationDocumentsDirectory()
/// - iOS: getLibraryDirectory()
/// - macOS: getLibraryDirectory()
/// - Windows: getApplicationSupportDirectory()
/// - Linux: getApplicationSupportDirectory()
/// If the app is running in debug mode on desktop platforms (Windows, Linux, macOS),
/// it will return a custom directory named 'DEBUG_STORAGE' in the current project directory.
///
Future<Directory> getCorrectDirectory() async {
  final String platform = Platform.operatingSystem;

  if (kDebugMode && <String>['windows', 'linux', 'macos'].contains(platform)) {
    // Get the desktop project directory
    final Directory projectDirectory = Directory.current;
    // Create a debug storage directory
    final Directory desktopDebugStorageDirectory = Directory(
      '${projectDirectory.path}/DEBUG_STORAGE',
    );
    // Ensure the directory exists
    await desktopDebugStorageDirectory.create(recursive: true);
    return desktopDebugStorageDirectory;
  }

  switch (platform) {
    case 'android':
      return getApplicationDocumentsDirectory();
    case 'ios':
    case 'macos':
      return getLibraryDirectory();
    case 'windows':
    case 'linux':
      return getApplicationSupportDirectory();
    default:
      return getTemporaryDirectory();
  }
}
