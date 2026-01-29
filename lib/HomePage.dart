import 'package:flutter/material.dart';
import 'package:comic_king/screens/Home.dart';
import 'package:comic_king/screens/Characters.dart' as myScreens;
import 'package:comic_king/screens/Wiki.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [Home(), myScreens.Characters(), Wiki()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главное'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Персонажи'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Вики'),
        ],
      ),
    );
  }
}