import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/subject.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Subject> subjectList = <Subject>[];
  String titlecenter = "Loading...";
  var numofpage, curpage = 1;
  var color;
  late double screenHeight, screenWidth, resWidth;
  late int gridcount;
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
  void initState() {
    super.initState();
    _loadSubjects(1);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      gridcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      gridcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tutor App'),
        backgroundColor: Colors.indigo,
      ),
      body: subjectList.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
          : Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("Subjects Available",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(subjectList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/courses/" +
                                      subjectList[index].subjectId.toString() +
                                      '.png',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(
                                        subjectList[index]
                                            .subjectName
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("RM " +
                                          double.parse(subjectList[index]
                                                  .subjectPrice
                                                  .toString())
                                              .toStringAsFixed(2)),
                                      Text(subjectList[index]
                                          .tutorId
                                          .toString()),
                                      Text(subjectList[index]
                                          .subjectSessions
                                          .toString()),
                                      Text(subjectList[index]
                                          .subjectRating
                                          .toString()),
                                    ],
                                  ))
                            ],
                          )),
                        );
                      }))),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadSubjects(index)},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
      /*body: Center(
        child: SizedBox(
          width: resWidth * 2,
          height: screenHeight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: const [
                Text(
                  "Subjects Available",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),*/
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: const <Widget>[
          Icon(Icons.book_rounded, color: Colors.indigo),
          Icon(Icons.person_add_rounded, color: Colors.indigo),
          Icon(Icons.doorbell_rounded, color: Colors.indigo),
          Icon(Icons.bookmark, color: Colors.indigo),
          Icon(Icons.book_rounded, color: Colors.indigo),
        ],
        onTap: _onItemTap,
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const SubjectScreen()));
      /*switch (index) {
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
      }*/
    });
  }

  void _loadSubjects(int pageno) {
    curpage = pageno;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_subjects.php"),
        body: {
          'pageno': pageno.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['subjects'] != null) {
          subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subject.fromJson(v));
          });
        } else {
          titlecenter = "No Subject Available";
        }
        setState(() {});
      } else {
        //do something
      }
    });
  }
}
