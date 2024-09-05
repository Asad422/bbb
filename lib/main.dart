import 'dart:async';
import 'package:bbb/select_level_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {

  runApp(MyGame());
}

class MyGame extends StatelessWidget {


  const MyGame({super.key,});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectLevelPage(),
    );
  }
}
