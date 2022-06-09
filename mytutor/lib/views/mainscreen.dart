import 'package:flutter/material.dart';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/loginscreen.dart';
import 'package:mytutor/views/subjectscreen.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Subjects',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_rounded),
            label: 'Tutors',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.doorbell_rounded),
            label: 'Subscribe',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favourite',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Profile',
            backgroundColor: Colors.indigo,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        onTap: _onItemTap,
      ),
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
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SubjectScreen()));*/
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
