import 'package:flutter/material.dart';
import 'package:mytutor_midtermtest/views/favouritescreen.dart';
import 'package:mytutor_midtermtest/views/profilescreen.dart';
import 'package:mytutor_midtermtest/views/subjectscreen.dart';
import 'package:mytutor_midtermtest/views/subscribescreen.dart';
import 'package:mytutor_midtermtest/views/tutorscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenHeight = 0.0, screenWidth = 0.0;
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "MyTutorApp";

  @override
  void initState() {
    super.initState();
    tabchildren = const [
      SubjectScreen(),
      TutorScreen(),
      SubscribeScreen(),
      FavouriteScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.indigo,
        items: const [
          Icon(Icons.auto_stories_rounded, color: Colors.indigo),
          Icon(Icons.badge_rounded, color: Colors.indigo),
          Icon(Icons.doorbell_rounded, color: Colors.indigo),
          Icon(Icons.notifications_rounded, color: Colors.indigo),
          Icon(Icons.person_add_alt_rounded, color: Colors.indigo),
        ],
        onTap: onTabTapped,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
