import 'package:book_library/pages/homepage.dart';
import 'package:book_library/providers/checkbox_provider.dart';
import 'package:book_library/providers/download_books_provider.dart';
import 'package:book_library/providers/saved_books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SavedBooksProvider()),
        ChangeNotifierProvider(create: (context) => DownloadBooksProvider()),
        ChangeNotifierProvider(create: (context) => CheckBoxProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 23),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 25, 115, 233),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
