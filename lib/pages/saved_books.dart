// Saved Books Code

import 'package:book_library/pages/book_details.dart';
import 'package:book_library/providers/saved_books_provider.dart';
import 'package:book_library/utils/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedBooks extends StatefulWidget {
  const SavedBooks({super.key});

  @override
  State<SavedBooks> createState() => _SavedBooksState();
}

class _SavedBooksState extends State<SavedBooks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Books",
        ),
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      body: Consumer<SavedBooksProvider>(
        builder: (context, dataManager, child) {
          return dataManager.savedBooks.isEmpty
              ? const Center(
                  child: Text(
                  "Saved Books will be Displayed Here",
                  style: TextStyle(fontSize: 16),
                ))
              : ListView.builder(
                  itemCount: dataManager.savedBooks.length,
                  itemBuilder: (context, index) {
                    final book = dataManager.savedBooks[index];
                    var bookThumbnail =
                        book.volumeInfo?.imageLinks?.thumbnail ??
                            "https://demofree.sirv.com/nope-not-here.jpg";
                    var bookTitle =
                        book.volumeInfo?.title?.toString() ?? "Unknown Title";
                    var author = book.volumeInfo?.authors?.join(", ") ?? "N/A";
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetails(book: book),
                            ));
                      },
                      child: ListTile(
                        leading: Image.network(
                          bookThumbnail,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Title: $bookTitle',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Authors: $author',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          // Add more details or actions as needed
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
