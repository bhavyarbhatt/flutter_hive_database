import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_database/models/albun.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<Album> futureAlbum;


@override
  void initState() {
    super.initState();
        futureAlbum = fetchAlbum();

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Hive Database")),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data!.title);
            }else if(snapshot.hasError){
                return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),

    );
  }

  Future<Album> fetchAlbum() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
      if(response.statusCode == 200  ){
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }else {
        throw Exception("Failed to load ");
      }
  }



  
  }

