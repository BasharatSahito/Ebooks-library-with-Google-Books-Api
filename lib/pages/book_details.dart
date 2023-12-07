import 'package:book_library/services/models/booksmodel.dart';
import 'package:book_library/utils/my_button.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  final Items book;
  const BookDetails({super.key, required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    var previewLink = widget.book.volumeInfo?.previewLink?.toString();
    var downloadLink = widget.book.accessInfo?.pdf?.downloadLink?.toString();
    var bookThumbnail =
        widget.book.volumeInfo?.imageLinks?.thumbnail.toString();
    var bookTitle = widget.book.volumeInfo?.title?.toString();
    var printType = widget.book.volumeInfo?.printType?.toString();
    var description = widget.book.volumeInfo?.description?.toString();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(bookTitle ?? ''),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Thumbnail
              Center(
                child: Image(image: NetworkImage(bookThumbnail ?? '')),
              ),
              const SizedBox(height: 16),

              // Book Title
              Text(
                'Title: ${bookTitle ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: MyButton(
                  btnTitles:
                      previewLink != null ? "Preview" : "Preview Unavailable",
                  link: previewLink.toString(),
                ),
              ),
              MyButton(
                btnTitles:
                    downloadLink != null ? "Download" : "Download Unavailable",
                link: downloadLink.toString(),
                isDisabled: downloadLink == null,
              ),
              const Flexible(
                child: MyButton(
                  btnTitles: "Add to Library",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
