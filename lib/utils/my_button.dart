import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyButton extends StatefulWidget {
  final String btnTitles;
  final String link;
  final bool isDisabled;

  const MyButton({
    super.key,
    required this.btnTitles,
    this.link = "",
    this.isDisabled = false,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(5), // Adjust padding as needed
      ),
      onPressed: widget.isDisabled
          ? null // Disable the button if isDisabled is true
          : () async {
              if (widget.link != "") {
                if (!await launchUrl(Uri.parse(widget.link),
                    mode: LaunchMode.platformDefault)) {
                  throw Exception('Could not launch ${widget.link}');
                }
              } else {
                print("STUNNER");
              }
            },
      child: Text(widget.btnTitles),
    );
  }
}
