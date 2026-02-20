import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AssetFileService {
  const AssetFileService();

  /// Copies an asset file to the device's documents directory.
  /// Returns null if the operation fails.
  Future<File?> materializeAssetToFile(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();

      final dir = await getApplicationDocumentsDirectory();
      final safeName = assetPath.split('/').last;
      final outFile = File('${dir.path}/$safeName');

      if (await outFile.exists()) {
        final existingLen = await outFile.length();
        if (existingLen == bytes.length) return outFile;
      }

      await outFile.writeAsBytes(bytes, flush: true);
      return outFile;
    } catch (e, stack) {
      debugPrint('AssetFileService.materializeAssetToFile failed: $e');
      debugPrint(stack.toString());
      return null;
    }
  }
}
