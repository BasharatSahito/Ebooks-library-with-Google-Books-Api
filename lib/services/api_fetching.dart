import 'package:book_library/services/models/booksmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchApi {
  Future<BooksModel> getBooks(String searchQuery, String filter) async {
    String googleApiKey = dotenv.get('GOOGLE_API_KEY', fallback: '');

    var apiKey = googleApiKey;
    var url =
        "https://www.googleapis.com/books/v1/volumes?q=$searchQuery$filter&maxResults=40&key=";
    try {
      final response = await http.get(Uri.parse("$url$apiKey"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return BooksModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch books');
      }
    } catch (error) {
      rethrow;
    }
  }
}
