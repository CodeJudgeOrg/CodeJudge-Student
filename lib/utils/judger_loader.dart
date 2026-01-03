import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// Load my library into a temporary directory (platform dependent)
Future<DynamicLibrary> loadJudgerLibrary() async {
  late final String assetPath;
  late final String fileName;

  if (Platform.isLinux) {
    assetPath = 'assets/native/linux/libjudger.so';
    fileName = 'libjudger.so';
  } else if (Platform.isWindows) {
    assetPath = 'assets/native/windows/judger.dll';
    fileName = 'judger.dll';
  } else {
    throw UnsupportedError("Unsupported platform");
  }

  // Load the asset
  final byteData = await rootBundle.load(assetPath);

  // Copy to a temporary directory because DynamicLibrary.open() needs a real file
  final tempDir = await getTemporaryDirectory();
  final libPath = '${tempDir.path}/$fileName';

  final file = File(libPath);
  await file.writeAsBytes(byteData.buffer.asUint8List());

  return DynamicLibrary.open(libPath);
}
