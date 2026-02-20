import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';

import 'asset_file_service.dart';

final assetFileServiceProvider = Provider<AssetFileService>((ref) {
  return const AssetFileService();
});

final fileOpenServiceProvider = Provider<FileOpenService>((ref) {
  final assetFiles = ref.watch(assetFileServiceProvider);
  return FileOpenService(assetFiles);
});

class FileOpenService {
  const FileOpenService(this._assetFiles);

  final AssetFileService _assetFiles;

  /// Opens an asset file externally. Returns an error result if opening fails.
  Future<OpenResult> openAssetFileExternally(String assetPath) async {
    try {
      final file = await _assetFiles.materializeAssetToFile(assetPath);
      if (file == null) {
        return OpenResult(
          type: ResultType.error,
          message: 'Failed to prepare file for opening',
        );
      }
      return OpenFilex.open(file.path);
    } catch (e, stack) {
      debugPrint('FileOpenService.openAssetFileExternally failed: $e');
      debugPrint(stack.toString());
      return OpenResult(
        type: ResultType.error,
        message: 'Failed to open file: $e',
      );
    }
  }
}
