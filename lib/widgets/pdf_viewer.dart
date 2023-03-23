import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: PdfController(
        document: PdfDocument.openFile(path),
      ),
    );
  }
}
