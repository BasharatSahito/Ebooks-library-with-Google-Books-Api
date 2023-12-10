import 'package:book_library/services/models/booksmodel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyButton extends StatefulWidget {
  final String btnTitles;
  final String link;
  final bool isDisabled;
  final bool saveBook;
  final Items? book;
  final IconData icon;
  final VoidCallback? onPressed;
  const MyButton({
    super.key,
    required this.btnTitles,
    this.link = "",
    this.isDisabled = false,
    this.saveBook = false,
    this.book,
    required this.icon,
    this.onPressed,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        widget.icon,
        color: Colors.white,
      ),
      label: Text(
        widget.btnTitles,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 7, 52, 110),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(0), // Adjust padding as needed
      ),
      onPressed: widget.isDisabled
          ? null // Disable the button if isDisabled is true
          : () async {
              if (widget.link != "") {
                if (!await launchUrl(Uri.parse(widget.link),
                    mode: LaunchMode.platformDefault)) {
                  throw Exception('Could not launch ${widget.link}');
                }
              }
              if (widget.saveBook) {
                widget.onPressed?.call(); // Call the callback
              }
            },
    );
  }
}
