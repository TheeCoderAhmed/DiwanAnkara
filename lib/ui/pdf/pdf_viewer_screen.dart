import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/file_open_service.dart';

class PdfViewerScreen extends ConsumerWidget {
  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.pdfAssetPath,
  });

  final String title;
  final String pdfAssetPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<File?>(
        future: ref
            .read(assetFileServiceProvider)
            .materializeAssetToFile(pdfAssetPath),
        builder: (context, snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('تعذر فتح الملف'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final file = snapshot.data!;
          return PDFView(
            filePath: file.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onError: (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('خطأ في عرض PDF: $e')));
            },
          );
        },
      ),
    );
  }
}
