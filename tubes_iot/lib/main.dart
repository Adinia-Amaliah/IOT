import 'package:flutter/material.dart';
import 'package:tubes_iot/Pages/Homepage.dart';

void main() {
  runApp(Alarmgas());
}

class Alarmgas extends StatelessWidget {
  const Alarmgas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Gas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}