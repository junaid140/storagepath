import 'package:flutter/material.dart';
import 'package:storage_path_example/view/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData.light(),
  ));
}
