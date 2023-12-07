import 'package:book_library/pages/search_results.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final List<String> btnTitles;
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResults(
                        searchQuery: widget.btnTitles[index], category: true),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero, // Adjust padding as needed
            ),
            child: Text(
              widget.btnTitles[index],
              style: const TextStyle(fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
