import 'package:flutter/material.dart';
import 'package:mytutor_midtermtest/views/favouritescreen.dart';
import 'package:mytutor_midtermtest/views/profilescreen.dart';
import 'package:mytutor_midtermtest/views/subjectscreen.dart';
import 'package:mytutor_midtermtest/views/subscribescreen.dart';
import 'package:mytutor_midtermtest/views/tutorscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'models/user.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({Key? key, required this.user}) : super(key: key);

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
    tabchildren = [
      SubjectScreen(user: widget.user),
      const TutorScreen(),
      const SubscribeScreen(),
      const FavouriteScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
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
