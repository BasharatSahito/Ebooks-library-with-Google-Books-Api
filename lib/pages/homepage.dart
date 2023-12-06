import 'dart:convert';
import 'package:book_library/pages/downloadedbooks.dart';
import 'package:book_library/services/models/booksmodel.dart';
import 'package:book_library/pages/webview.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  var apiKey = "AIzaSyDrjrBKFLTqsg3ljsldZJxzP_JHfCFJYeI";
  var url =
      "https://www.googleapis.com/books/v1/volumes?q=flutter&filter=free-ebooks&maxResults=40&key=";
  Future<BooksModel> getBooks() async {
    try {
      final response = await http.get(Uri.parse("$url$apiKey"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data is Map<String, dynamic> &&
            data.containsKey('items') &&
            data['items'] is List) {
          return BooksModel.fromJson(data);
        } else {
          print('Invalid JSON structure: $data');
          throw Exception('Invalid JSON structure');
        }
      } else {
        print('Failed to fetch books. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch books');
      }
    } catch (error, stackTrace) {
      print('Error in getBooks: $error\n$stackTrace');
      rethrow;
    }
  }

  List<String> downloadedBooks = [];

  Future<void> downloadBook(String downloadLink, String title) async {
    print("THE PREVIEW LINK IS $downloadLink");
    if (!await launchUrl(Uri.parse(downloadLink),
        mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $downloadLink');
    }
    // const String baseUrl = "https://www.ibm.com/downloads/cas/GJ5QVQ7X";
    // final response = await http.get(Uri.parse(downloadLink));
    // if (response.statusCode == 200) {

    // var dir = await getApplicationDocumentsDirectory();
    // File file = File("${dir.path}/$title.pdf");
    // file.writeAsBytesSync(response.bodyBytes, flush: true);
    // downloadedBooks.add(file.path);
    // print("Content-Type: ${response.headers["content-type"]}");

    // print("Response Status Code: ${response.statusCode}");
    // print("Response Body Length: ${response.bodyBytes.length}");
    // print("Downloaded Books List is: $downloadedBooks");
    // } else {
    //   // print("Failed to download: ${response.statusCode}");
    // }
  }

  Future<bool> _requestPermission(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      var re = await Permission.manageExternalStorage.request();
      if (re.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  Future<void> checkAndRequestPermissions() async {
    PermissionStatus status = await Permission.storage.status;
    print("Permission Status: $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DownloadedBooks(downloadedBooks: downloadedBooks),
                    ));
              },
              child: const Text("Downloaded Books"))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<BooksModel>(
              future: getBooks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.items!.length,
                    itemBuilder: (context, index) {
                      var book = snapshot.data!.items![index];
                      var downloadLink =
                          book.accessInfo!.epub!.downloadLink.toString();
                      var previewLink = book.volumeInfo!.previewLink.toString();
                      return ListTile(
                        leading: Text(
                          index.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        title: Text(book.volumeInfo!.title.toString()),
                        subtitle:
                            Text(book.volumeInfo!.authors?.join(", ") ?? ""),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            if (await _requestPermission(Permission.storage) ==
                                true) {
                              print("Permission is granted");

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ViewUrl(url: previewLink),
                                  ));

                              // downloadBook(
                              //   previewLink,
                              //   book.volumeInfo!.title.toString(),
                              // );
                            } else {
                              print("permission is not granted");
                            }
                          },
                          child: const Text("Preview"),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
