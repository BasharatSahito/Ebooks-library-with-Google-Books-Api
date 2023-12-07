import 'package:book_library/utils/my_drawer.dart';
import 'package:flutter/material.dart';

class SavedBooks extends StatefulWidget {
  const SavedBooks({super.key});

  @override
  State<SavedBooks> createState() => _SavedBooksState();
}

class _SavedBooksState extends State<SavedBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Books",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
    );
  }
}
