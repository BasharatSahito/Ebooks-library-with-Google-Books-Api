import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AlertBox extends StatefulWidget {
  final Function(bool?) onCheckboxChanged;
  bool isFreeEbookSelected;
  AlertBox({
    super.key,
    required this.onCheckboxChanged,
    required this.isFreeEbookSelected,
  });

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter Results"),
      content: SizedBox(
        height: 100, // Set the height as needed
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.isFreeEbookSelected,
                  onChanged: (bool? value) {
                    widget.isFreeEbookSelected = value!;
                    setState(() {
                      widget.onCheckboxChanged(value);
                    });
                  },
                ),
                const Text(
                  'Free eBooks',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle the selection and close the dialog
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
