import 'package:flutter/material.dart';

class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Letters',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),), 
      ),
    );
  }
}