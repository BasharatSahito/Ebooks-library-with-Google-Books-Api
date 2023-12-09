import 'package:book_library/providers/checkbox_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AlertBox extends StatefulWidget {
  final Function(bool?) onCheckboxChanged;
  AlertBox({
    super.key,
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
                Consumer<CheckBoxProvider>(
                  builder: (context, provider, child) {
                    return Checkbox(
                      value: provider.isFreeEbookSelected,
                      onChanged: (bool? value) {
                        provider.onCheckboxChanged(value!);

                        widget.onCheckboxChanged(
                          provider.isFreeEbookSelected,
                        );
                      },
                    );
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
