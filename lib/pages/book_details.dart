import 'package:book_library/providers/saved_books_provider.dart';
import 'package:book_library/services/models/booksmodel.dart';
import 'package:book_library/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  final Items book;
  const BookDetails({super.key, required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    super.initState();

    context.read<SavedBooksProvider>().initSavedBook(widget.book);
  }

  void _toggleSaveBook() {
    final dataManager = context.read<SavedBooksProvider>();

    if (dataManager.isBookSaved!) {
      dataManager.removeFromSavedBooks(widget.book);
    } else {
      dataManager.addToSavedBooks(widget.book);
    }
    dataManager.toggleBookSaved();
    // isBookSaved = !isBookSaved; // Toggle the saved state
  }

  @override
  Widget build(BuildContext context) {
    var previewLink = widget.book.volumeInfo?.previewLink?.toString();
    var downloadLink = widget.book.accessInfo?.epub?.downloadLink?.toString();
    var bookThumbnail = widget.book.volumeInfo?.imageLinks?.thumbnail ??
        "https://demofree.sirv.com/nope-not-here.jpg";
    var bookTitle = widget.book.volumeInfo?.title?.toString();
    var printType = widget.book.volumeInfo?.printType?.toString();
    var description = widget.book.volumeInfo?.description?.toString();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(bookTitle ?? ''),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Thumbnail
              Center(
                child: Image(image: NetworkImage(bookThumbnail)),
              ),
              const SizedBox(height: 16),

              // Book Title
              Text(
                bookTitle ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Authors
              Text(
                'Authors: ${widget.book.volumeInfo?.authors?.join(", ") ?? "N/A"}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              // Description
              const Text(
                'About this edition:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Published Date
                    Text(
                      'Published Date: ${widget.book.volumeInfo?.publishedDate ?? "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    // Page Count
                    Text(
                      'Page Count: ${widget.book.volumeInfo?.pageCount ?? "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    // Categories
                    Text(
                      'Categories: ${widget.book.volumeInfo?.categories?.join(", ") ?? "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    // Language
                    Text(
                      'Language: ${widget.book.volumeInfo?.language ?? "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    // Language
                    Text(
                      'Print Type: ${printType ?? "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description?.toString() ?? "N/A",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 7, 52, 110),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: MyButton(
                btnTitles:
                    previewLink != null ? "Preview" : "Preview Unavailable",
                link: previewLink.toString(),
                icon: Icons.remove_red_eye_outlined,
              ),
            ),
            MyButton(
              btnTitles:
                  downloadLink != null ? "Download" : "Download Unavailable",
              link: downloadLink.toString(),
              isDisabled: downloadLink == null,
              icon: Icons.download,
            ),
            Flexible(
              child: Consumer<SavedBooksProvider>(
                builder: (context, value, child) {
                  return MyButton(
                    btnTitles: value.isBookSaved! ? "Remove" : "Save",
                    saveBook: true,
                    book: widget.book,
                    icon: value.isBookSaved!
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    onPressed: _toggleSaveBook,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
