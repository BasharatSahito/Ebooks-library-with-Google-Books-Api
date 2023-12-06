import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfPath; // Replace with your PDF file path

  const PDFViewerPage({super.key, required this.pdfPath});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    File pdfFile = File(widget.pdfPath);
    if (pdfFile.existsSync()) {
      print("File exists");
    } else {
      print("File does not exist");
    }
    print(widget.pdfPath);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: widget.pdfPath,
      ),
    );
  }
}
