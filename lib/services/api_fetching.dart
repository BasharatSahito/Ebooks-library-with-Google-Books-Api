import 'package:book_library/services/models/booksmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchApi {
  Future<BooksModel> getBooks(String searchQuery, String filter) async {
    print("THE VALUE OF FILTER IS : $filter");
    var apiKey = "AIzaSyDrjrBKFLTqsg3ljsldZJxzP_JHfCFJYeI";
    var url =
        "https://www.googleapis.com/books/v1/volumes?q=$searchQuery$filter&maxResults=40&key=";
    try {
      final response = await http.get(Uri.parse("$url$apiKey"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return BooksModel.fromJson(data);
      } else {
        print('Failed to fetch books. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch books');
      }
    } catch (error, stackTrace) {
      print('Error in getBooks: $error\n$stackTrace');
      rethrow;
    }
  }
}
