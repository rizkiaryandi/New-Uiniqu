import 'package:flutter/material.dart';
import 'package:uiniqu/models/auth_model.dart';
import 'package:uiniqu/models/tadarus_model.dart';
import './home.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';

Future<void> main() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TadarusAdapter());
  Hive.registerAdapter(AuthModelAdapter());

  // await Hive.openBox<TadarusAdapter>('tadarus');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uiniqu',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins'),
      home: const HomePage(title: 'Uiniqu'),
    );
  }
}
