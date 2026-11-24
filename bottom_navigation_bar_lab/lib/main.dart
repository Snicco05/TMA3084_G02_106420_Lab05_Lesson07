import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

class TabModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TabModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavLab(),
    );
  }
}

class BottomNavLab extends StatelessWidget {
  const BottomNavLab({super.key});

  static const List<Widget> screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 05: Nico Navigation'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TabModel>(
        builder: (context, tabModel, child) => screens[tabModel.currentIndex],
      ),
      bottomNavigationBar: Consumer<TabModel>(
        builder: (context, tabModel, child) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          backgroundColor: Colors.purpleAccent,
          iconSize: 30,
          currentIndex: tabModel.currentIndex,
          onTap: (int index) {
            context.read<TabModel>().updateIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          ],
        ),
      ),
    );
  }
}