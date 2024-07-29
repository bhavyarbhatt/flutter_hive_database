import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/models/albun.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;  

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDir = await getApplicationCacheDirectory();
  Hive.init(documentsDir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

late Future<Album> futureAlbum;

@override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
              return Text(snapshot.data!.title);
          } else if(snapshot.hasError){
              return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
  
  Future<Album> fetchAlbum() async {
        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/albums/1')
        );

        if(response.statusCode == 200 ){
          return Album.fromJson(jsonDecode(response.body)  as Map<String, dynamic>);
        } else {
          throw Exception('Failed to load album');
        }
  }

}