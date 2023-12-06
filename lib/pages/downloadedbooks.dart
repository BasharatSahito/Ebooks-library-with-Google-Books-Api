import 'package:flutter/material.dart';
import 'package:book_library/pages/viewpdf.dart';

class DownloadedBooks extends StatefulWidget {
  final List<String> downloadedBooks;
  const DownloadedBooks({super.key, required this.downloadedBooks});

  @override
  State<DownloadedBooks> createState() => _DownloadedBooksState();
}

class _DownloadedBooksState extends State<DownloadedBooks> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloaded Books (${widget.downloadedBooks.length})"),
      ),
      body: ListView.builder(
        itemCount: widget.downloadedBooks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                "Book $index: ${getFileName(widget.downloadedBooks[index])}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PDFViewerPage(pdfPath: widget.downloadedBooks[index])),
              );
            },
          );
        },
      ),
    );
  }

  // Function to get the file name from the path
  String getFileName(String path) {
    List<String> parts = path.split('/');
    return parts.isNotEmpty ? parts.last : path;
  }
}
