import 'package:book_library/pages/downloadedbooks.dart';
import 'package:book_library/pages/homepage.dart';
import 'package:book_library/pages/saved_books.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Ebook Library',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
        ),
        ListTile(
          title: const Text('Saved Books'),
          onTap: () {
            // Navigate to the screen for saved books or perform any action
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SavedBooks(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text("Downloaded Books"),
          onTap: () {
            // Navigate to the screen for saved books or perform any action
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DownloadedBooks(),
              ),
            );
          },
        ),
      ],
    );
  }
}
