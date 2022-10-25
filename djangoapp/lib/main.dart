import 'dart:convert';
import 'package:djangoapp/create.dart';
import 'package:djangoapp/note.dart';
import 'package:djangoapp/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import "package:get/get.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Django demo app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }

  _retrieveNotes() async {
    notes = [];

    List response = json.decode((await client.get(retreiveUrl)).body);
    response.forEach((element) {
      notes.add(Note.fromMapp(element));
    });

    setState(() {});
  }

  void _addNote() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("Blog post"),
              onTap: () {},
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreatePage(),
          ),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
