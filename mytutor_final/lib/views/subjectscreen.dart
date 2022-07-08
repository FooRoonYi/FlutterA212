import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor_final/home.dart';
import 'package:mytutor_final/views/cartscreen.dart';
import 'package:mytutor_final/views/loginscreen.dart';
import 'package:mytutor_final/views/userresgistrationscreen.dart';

import '../constants.dart';
import '../models/subject.dart';
import '../models/user.dart';

class SubjectScreen extends StatefulWidget {
  final User user;
  const SubjectScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Subject> subjectList = <Subject>[];
  String titlecenter = "Loading...";
  var numofpage, curpage = 1;
  var color;
  late double screenHeight, screenWidth, resWidth;
  late int gridcount;
  TextEditingController searchController = TextEditingController();
  String search = "";
  String name = "";
  String dropdownvalue = 'Programming 101';
  var types = [
    'Programming 101',
    'Programming 201',
    'Introduction to Web programming',
    'Web programming advanced',
    'Python for Everybody',
    'Introduction to Computer Science',
    'Code Yourself! An Introduction to Programming',
    'IBM Full Stack Software Developer Professional Certificate',
    'Graphic Design Specialization',
    'Fundamentals of Graphic Design',
    'Full-Stack Web Development with React',
    'Software Design and Architecture',
    'Software Testing and Automation',
    'Introduction to Cyber Security',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadSubjects(1, search);
    });
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
        automaticallyImplyLeading: true,
        title: const Text('Subjects'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
          TextButton.icon(
            onPressed: () async {
              if (widget.user.email == "guest@mytutorapp.com") {
                _loadOptions();
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CartScreen(
                              user: widget.user,
                            )));
                _loadSubjects(1, search);
                _loadMyCart();
              }
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(widget.user.cart.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
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
                      childAspectRatio: (1 / 1.5),
                      children: List.generate(subjectList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadSubjectDetails(index)},
                          child: Card(
                              color: Colors.indigo.shade50,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/mytutor/mobile/assets/courses/" +
                                          subjectList[index]
                                              .subjectId
                                              .toString() +
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
                                          const SizedBox(height: 10),
                                          Text(
                                            subjectList[index]
                                                .subjectName
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                              "RM ${double.parse(subjectList[index].subjectPrice.toString()).toStringAsFixed(2)}",
                                              textAlign: TextAlign.left),
                                          Text(
                                              "Session: ${subjectList[index].subjectSessions}",
                                              textAlign: TextAlign.left),
                                          Text(
                                              "Rating: ${subjectList[index].subjectRating}",
                                              textAlign: TextAlign.left),
                                        ],
                                      )),
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
                      color = Colors.indigo;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadSubjects(index + 1, "")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  void _loadSubjects(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse("${CONSTANTS.server}/mytutor/mobile/php/load_subjects.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
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
          titlecenter = "No Subjects Available Now";
        }
        setState(() {});
      } else {
        //do something
      }
    });
  }

  _loadOptions() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Please select",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: _onLogin,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child: const Text("Login")),
                ElevatedButton(
                    onPressed: _onRegister,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child: const Text("Register")),
              ],
            ),
          );
        });
  }

  _loadSubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Course Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor/mobile/assets/courses/" +
                      subjectList[index].subjectId.toString() +
                      '.png',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Subject ID: ${subjectList[index].subjectId}",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "\nSubject Name: ${subjectList[index].subjectName}",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "\nSubject Description: \n${subjectList[index].subjectDescription}",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "\nSubject Price: RM ${double.parse(subjectList[index].subjectPrice.toString()).toStringAsFixed(2)}",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "\nTutor ID: ${subjectList[index].tutorId}",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "\nSubject Sessions: ${subjectList[index].subjectSessions}",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "\nSubject Rating: ${subjectList[index].subjectRating}",
                    textAlign: TextAlign.justify,
                  ),
                ])
              ],
            )),
            actions: [
              SizedBox(
                  width: screenWidth / 1,
                  child: ElevatedButton(
                      onPressed: () {
                        _addtocartDialog(index);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                      ),
                      child: const Text("Add to cart"))),
            ],
          );
        });
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  height: screenHeight / 5,
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          search = searchController.text;
                          Navigator.of(context).pop();
                          _loadSubjects(1, search);
                        },
                        child: const Text("Search"),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void _addtocartDialog(int index) {
    if (widget.user.email == "guest@mytutorapp.com") {
      _loadOptions();
    } else {
      _addtoCartConfirmDialog(index);
    }
  }

  _addtoCartConfirmDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Are you sure?",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _onYes(index);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child: const Text("Yes")),
                ElevatedButton(
                    onPressed: _onNo,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child: const Text("No")),
              ],
            ),
          );
        });
  }

  void _onYes(int index) {
    _addtoCart(index);
  }

  void _onNo() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => Home(
                  user: widget.user,
                )));
  }

  void _onLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const LoginScreen()));
  }

  void _onRegister() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => const UserResgisterScreen()));
  }

  void _addtoCart(int index) {
    http.post(
        Uri.parse("${CONSTANTS.server}/mytutor/mobile/php/insert_cart.php"),
        body: {
          "email": widget.user.email.toString(),
          "subject_id": subjectList[index].subjectId.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
        Fluttertoast.showToast(
            msg: "Added into the cart successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _loadMyCart() {
    if (widget.user.email != "guest@mytutorapp.com") {
      http.post(
          Uri.parse("${CONSTANTS.server}/mytutor/mobile/php/load_cartqty.php"),
          body: {
            "email": widget.user.email.toString(),
          }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      ).then((response) {
        print(response.body);
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          print(jsondata['data']['carttotal'].toString());
          setState(() {
            widget.user.cart = jsondata['data']['carttotal'].toString();
          });
        }
      });
    }
  }
}
