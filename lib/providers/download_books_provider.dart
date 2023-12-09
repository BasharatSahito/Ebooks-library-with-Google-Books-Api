import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadBooksProvider extends ChangeNotifier {
  final List<File> _downloadedPdfFiles = [];

  List<File> get downloadedPdfFiles => _downloadedPdfFiles;

  void addDownloadedBooks(File file) {
    _downloadedPdfFiles.add(file);
    _saveDownloadedBooks();
    notifyListeners();
  }

  //Shared Prefernces Code

  DownloadBooksProvider() {
    _getDownloadedBooks();
    notifyListeners();
  }

  void _saveDownloadedBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the list of files to a list of strings (file paths)
    final List<String> filePaths =
        _downloadedPdfFiles.map((file) => file.path).toList();

    // Save the list of strings to SharedPreferences
    await prefs.setStringList('booksKey', filePaths);
    notifyListeners();
  }

  void _getDownloadedBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the list of strings (file paths) from SharedPreferences
    final List<String>? items = prefs.getStringList('booksKey');
    if (items != null) {
      // Convert the list of strings back to a list of files
      _downloadedPdfFiles.addAll(items.map((filePath) => File(filePath)));
      notifyListeners();
    }
  }

  void removeDownloadBooks(File file) async {
    _downloadedPdfFiles.remove(file);
    _saveDownloadedBooks();
    notifyListeners();
  }
}
