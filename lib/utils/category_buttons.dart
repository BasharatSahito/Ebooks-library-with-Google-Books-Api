import 'package:book_library/pages/search_results.dart';
import 'package:book_library/providers/checkbox_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryButton extends StatefulWidget {
  final List<List<dynamic>> btnTitles;
  const CategoryButton({super.key, required this.btnTitles});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of buttons per row
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: widget.btnTitles.length, // Total number of buttons
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              context.read<CheckBoxProvider>().onCheckboxChanged(false);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResults(
                        searchQuery: widget.btnTitles[index][0],
                        category: true),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 52, 110),
              shadowColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero, // Adjust padding as needed
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.btnTitles[index][1],
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.btnTitles[index][0],
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
