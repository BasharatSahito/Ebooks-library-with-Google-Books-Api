//HOMEPAGE CODE

import 'package:book_library/pages/search_results.dart';
import 'package:book_library/utils/category_buttons.dart';
import 'package:book_library/utils/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final List<List<dynamic>> buttonTitles = [
    ["Computer", const Icon(Icons.computer, color: Colors.white, size: 30)],
    ["History", const Icon(Icons.history_edu, color: Colors.white, size: 30)],
    [
      "Agriculture",
      const Icon(Icons.agriculture, color: Colors.white, size: 30)
    ],
    ["Programming", const Icon(Icons.monitor, color: Colors.white, size: 30)],
    [
      "Medical",
      const Icon(Icons.medical_services_outlined, color: Colors.white, size: 30)
    ],
    [
      "Science",
      const Icon(Icons.science_outlined, color: Colors.white, size: 30)
    ],
    [
      "Mathematics",
      const Icon(Icons.calculate_rounded, color: Colors.white, size: 30)
    ],
    [
      "Poetry",
      const Icon(Icons.event_note_sharp, color: Colors.white, size: 30)
    ],
    [
      "Networking",
      const Icon(Icons.network_cell_outlined, color: Colors.white, size: 30)
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "E Books Library",
        ),
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                onSubmitted: (String value) {
                  if (searchController.text.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResults(
                              searchQuery: searchController.text.toString(),
                              category: false),
                        )).then((value) {
                      searchController.clear();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Search is Empty'),
                    ));
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (searchController.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResults(
                                  searchQuery: searchController.text.toString(),
                                  category: false),
                            )).then((value) {
                          searchController.clear();
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Search is Empty'),
                        ));
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: const Text(
                  "Categories",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(child: CategoryButton(btnTitles: buttonTitles))
            ],
          ),
        ),
      ),
    );
  }
}
