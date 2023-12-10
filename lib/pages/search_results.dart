import 'package:book_library/pages/book_details.dart';
import 'package:book_library/providers/checkbox_provider.dart';
import 'package:book_library/services/api_fetching.dart';
import 'package:book_library/services/models/booksmodel.dart';
import 'package:book_library/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  final String searchQuery;
  final bool category;
  const SearchResults(
      {super.key, required this.searchQuery, required this.category});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category
              ? " ${widget.searchQuery} Category"
              : " ${widget.searchQuery} Search Results",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Adjusted to center
              children: [
                const Text(
                  "Filter",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertBox(
                          onCheckboxChanged: (value) {
                            context
                                .read<CheckBoxProvider>()
                                .onCheckboxChanged(value!);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Consumer<CheckBoxProvider>(
            builder: (context, value, child) {
              return Expanded(
                child: FutureBuilder<BooksModel>(
                  future: FetchApi().getBooks(widget.searchQuery,
                      value.isFreeEbookSelected! ? "&filter=free-ebooks" : ""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 60,
                        ),
                        itemCount: snapshot.data!.items!.length,
                        itemBuilder: (context, index) {
                          var book = snapshot.data?.items?[index];
                          var bookTitle =
                              book?.volumeInfo?.title?.toString() ?? "NO TITLE";
                          var bookThumbnail =
                              book?.volumeInfo?.imageLinks?.thumbnail ??
                                  "https://demofree.sirv.com/nope-not-here.jpg";

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetails(book: book!),
                                    // settings: RouteSettings(
                                    //   arguments: context
                                    //       .read<SavedBooksProvider>()
                                    //       .isBookmarked(book!),
                                    // ),
                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    bookThumbnail,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    bookTitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   'Author: $bookAuthors',
                                //   style: const TextStyle(
                                //       overflow: TextOverflow.ellipsis),
                                // ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
