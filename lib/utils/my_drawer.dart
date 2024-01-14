// MY DRAWER CODE
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
      padding: EdgeInsets.zero, // This removes any default padding
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 25, 115, 233),
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align content to the bottom
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Icon(
                    Icons.book,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    'Ebook Library',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            size: 28,
          ),
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 17),
          ),
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
          leading: const Icon(
            Icons.book_rounded,
            size: 28,
          ),
          title: const Text(
            'Saved Books',
            style: TextStyle(fontSize: 17),
          ),
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
          leading: const Icon(
            Icons.download_for_offline,
            size: 28,
          ),
          title: const Text(
            "Downloaded Books",
            style: TextStyle(fontSize: 17),
          ),
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
