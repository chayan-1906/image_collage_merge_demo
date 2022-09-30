import 'package:flutter/material.dart';
import 'package:image_collage_merge_demo/image_collage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Collage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.redAccent,
          elevation: 0.0,
          centerTitle: true,
        ),
        primarySwatch: Colors.red,
        primaryColor: Colors.redAccent,
      ),
      home: const ImageCollageScreen(),
    );
  }
}
