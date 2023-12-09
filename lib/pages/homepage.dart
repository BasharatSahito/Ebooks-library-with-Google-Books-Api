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

  final List<String> buttonTitles = [
    "Computer",
    "Science",
    "Politics",
    "Art",
    "History",
    "Programming",
    "Agriculture",
    "Social Studies",
    "Biography",
    "Novel",
    "Poetry",
    "Autobiography"
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
              const Text(
                "Categories",
                style: TextStyle(fontSize: 25),
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
