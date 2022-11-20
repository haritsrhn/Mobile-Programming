import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController titleEditingController = TextEditingController();

  var _title = "No Result Found",
      _year = " ",
      _poster = "",
      _genre = " ",
      _plot = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        leading: const Icon(Icons.movie_creation_outlined),
        titleSpacing: 0,
        title: const Text(
          'myMovies',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 58, 58, 58),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                controller: titleEditingController,
                decoration: InputDecoration(
                  hintText: 'Movie title',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 58, 58, 58),
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: _loadMovies,
                child: const Text("Search"),
              ),
              const SizedBox(height: 30),
              Card(
                child: Container(
                  color: const Color.fromARGB(255, 58, 58, 58),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.network(
                        _poster,
                        height: 250,
                        width: 250,
                        errorBuilder: ((context, error, stackTrace) {
                          return Image.asset(
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                              'assets/images/movies.png');
                        }),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        _year,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        _genre,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        _plot,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMovies() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    String movieTitle = titleEditingController.text;

    var apiid = "be897ed";
    var url = Uri.parse(
        'http://www.omdbapi.com/?t=$movieTitle&apikey=$apiid&units=metric');

    var response = await http.get(url);
    var rescode = response.statusCode;

    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);

      setState(() {
        var title = parsedJson['Title'];
        var year = parsedJson['Year'];
        var poster = parsedJson['Poster'];
        var genre = parsedJson['Genre'];
        var plot = parsedJson['Plot'];

        _title = '$title';
        _year = '$year';
        _poster = '$poster';
        _genre = '$genre';
        _plot = '$plot';

        Fluttertoast.showToast(
            msg: "Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Not Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    progressDialog.dismiss();
  }
}
