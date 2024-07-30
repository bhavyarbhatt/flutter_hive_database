import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/models/albun.dart';
import 'package:hive_database/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;  

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // final documentsDir = await getApplicationCacheDirectory();
  // Hive.init(documentsDir.path);
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
      home:  HomePage(),
    );
  }
}

