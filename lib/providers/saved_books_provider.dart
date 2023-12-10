// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:book_library/services/models/booksmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedBooksProvider extends ChangeNotifier {
  final List<Items> _savedBooks = [];

  List<Items> get savedBooks => _savedBooks.reversed.toList();

  // SharedPreferences key for saved books
  static const String savedBookKey = 'saved_books';

  SavedBooksProvider() {
    _loadSavedBooks();
  }

  void addToSavedBooks(Items book) {
    _savedBooks.add(book);
    _saveSavedBooks();
    print("Book Added");
    print("Is BookMarked After Adding: ${isBookmarked(book)}");
    print("The Length of Saved Books after Adding is  = ${savedBooks.length}");
    notifyListeners();
  }

  bool isBookmarked(Items book) {
    return _savedBooks.any((savedBook) => savedBook.id == book.id);
  }

  void removeFromSavedBooks(Items book) {
    _savedBooks.removeWhere((savedBook) => savedBook.id == book.id);
    _saveSavedBooks();
    print("Book Removed");
    print("Is BookMarked After Remove: ${isBookmarked(book)}");
    print("The Length of Saved Books after remove is  = ${savedBooks.length}");
    notifyListeners();
  }

  Future<void> _loadSavedBooks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedBooksJson = prefs.getString(savedBookKey);
      if (savedBooksJson != null) {
        final List<dynamic> savedBookList = jsonDecode(savedBooksJson);
        _savedBooks.addAll(savedBookList.map((e) => Items.fromJson(e)));
        notifyListeners(); // Notify listeners after loading
      }
    } catch (e) {}
  }

  Future<void> _saveSavedBooks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedBooksJson =
          jsonEncode(_savedBooks.map((e) => e.toJson()).toList());
      prefs.setString(savedBookKey, savedBooksJson);
      notifyListeners(); // Notify listeners after loading
    } catch (e) {}
  }

  bool? _isBookSaved;

  bool? get isBookSaved => _isBookSaved;

  void initSavedBook(Items book) {
    print("Is BookMarked Contains: ${isBookmarked(book)}");
    _isBookSaved = isBookmarked(book);
  }

  void toggleBookSaved() {
    _isBookSaved = !_isBookSaved!;
  }
}
