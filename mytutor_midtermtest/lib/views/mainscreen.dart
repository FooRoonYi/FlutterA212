import 'package:flutter/material.dart';
import 'package:mytutor_midtermtest/views/subjectscreen.dart';
import 'package:mytutor_midtermtest/views/tutorscreen.dart';

import '../models/user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Subjects',
      style: optionStyle,
    ),
    Text(
      'Index 1: Tutors',
      style: optionStyle,
    ),
    Text(
      'Index 2: Subcribe',
      style: optionStyle,
    ),
    Text(
      'Index 3: Favourite',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tutor App'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   items: const <Widget>[
      //     Icon(Icons.book_rounded, color: Colors.indigo),
      //     Icon(Icons.person_add_rounded, color: Colors.indigo),
      //     Icon(Icons.doorbell_rounded, color: Colors.indigo),
      //     Icon(Icons.bookmark, color: Colors.indigo),
      //     Icon(Icons.book_rounded, color: Colors.indigo),
      //   ],
      //   onTap: _onItemTap,
      // ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SubjectScreen()));
          break;
        case 1:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const TutorScreen()));
          break;
        case 2:
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SubjectScreen()));*/
          break;
        case 3:
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SubjectScreen()));*/
          break;
        case 4:
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SubjectScreen()));*/
          break;
      }
    });
  }
}
