import 'package:flutter/material.dart';
import 'package:focus_mate/core/theme/theme.dart';
import 'package:focus_mate/presentation/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: AppTheame.appTheame,
      home: const HomeScreen(),
    );
  }
}

