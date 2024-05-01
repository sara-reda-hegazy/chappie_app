import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Numbers',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),), 
      ),
    );
  }
}