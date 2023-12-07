import 'package:flutter/material.dart';

class AlertBox extends StatefulWidget {
  bool isFreeEbookSelected;
  final Function(bool) onCheckboxChanged;
  AlertBox({
    super.key,
    required this.isFreeEbookSelected,
    required this.onCheckboxChanged,
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
                  value: widget
                      .isFreeEbookSelected, // Set the initial value of the checkbox
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isFreeEbookSelected = value ?? false;
                    });
                    widget.onCheckboxChanged(widget.isFreeEbookSelected);
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
