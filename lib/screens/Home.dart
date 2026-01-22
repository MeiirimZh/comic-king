import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главное')),
      body: Center(child: Column(spacing: 20.0, children: [
        Column(children: [
          Text('Персонаж дня', style: TextStyle(fontSize: 20, color: Color(0xFF4D4D4D))),
          Text('Синий Жук', style: TextStyle(fontSize: 32)),
        ],),
        Image.asset('assets/images/BlueBeetle.png', width: 240, height: 240, fit: BoxFit.contain),
        Text('Lorem ipsum dolor sit amet')
      ],))
    );
  }
}