// ignore_for_file: use_build_context_synchronously, empty_catches

import 'dart:io';
import 'package:book_library/pages/viewpdf.dart';
import 'package:book_library/providers/download_books_provider.dart';
import 'package:book_library/utils/my_drawer.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadedBooks extends StatefulWidget {
  const DownloadedBooks({super.key});

  @override
  State<DownloadedBooks> createState() => _DownloadedBooksState();
}

class _DownloadedBooksState extends State<DownloadedBooks> {
  Set<String> uniqueFilePaths = {};
  Future<void> pickFile() async {
    final downloadProvider =
        Provider.of<DownloadBooksProvider>(context, listen: false);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        List<File> pickedFiles =
            result.files.map((fileResult) => File(fileResult.path!)).toList();

        // Check for duplicates before adding to the list
        for (var file in pickedFiles) {
          if (!downloadProvider.downloadedPdfFiles
              .any((existingFile) => existingFile.path == file.path)) {
            downloadProvider.addDownloadedBooks(file);
          }
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Downloaded Books",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () async {
                  pickFile();
                },
                child: const Text(
                  "Import",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          )
        ],
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      body: Consumer<DownloadBooksProvider>(
        builder: (context, value, child) {
          return value.downloadedPdfFiles.isNotEmpty
              ? ListView.builder(
                  itemCount: value.downloadedPdfFiles.length,
                  itemBuilder: (context, index) {
                    var i = index + 1;
                    return ListTile(
                      leading: Text(
                        i.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      title: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFViewerPage(
                                      pdfPath: value
                                          .downloadedPdfFiles[index].path)));
                        },
                        child: Text(
                          value.downloadedPdfFiles[index].path.split('/').last,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      trailing: GestureDetector(
                          onTap: () {
                            value.removeDownloadBooks(
                                value.downloadedPdfFiles[index]);
                          },
                          child: const Icon(
                            Icons.delete,
                            size: 25,
                          )),
                      // You can add more details or actions as needed
                    );
                  },
                )
              : const Center(
                  child: Text(
                  "Import Downloaded Books to Read Here",
                  style: TextStyle(fontSize: 18),
                ));
        },
      ),
      // floatingActionButton: Tooltip(
      //   message: 'Import downloaded books to read',
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.blue,
      //     onPressed: () {
      //       // Add your onPressed logic here
      //     },
      //     child: Icon(
      //       Icons.info_outline,
      //       color: Colors.white,
      //     ),
      //   ),
      // )
    );
  }
}
