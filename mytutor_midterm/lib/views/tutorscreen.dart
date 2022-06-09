import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';
import '../models/tutor.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List<Tutor> tutList = <Tutor>[];
  String titlecenter = "Loading...";
  late double screenHeight, screenWidth, resWidth;
  // final df = DateFormat('dd/MM/yyyy hh:mm a');
  var numofpage, curpage = 1;
  var color;
  TextEditingController searchController = TextEditingController();
  String search = "";
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
    _loadTutors(1, search);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Tutor'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {
        //       _loadSearchDialog();
        //     },
        //   )
        // ],
      ),
      body: tutList.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
          : Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("Tutors Available",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.5),
                      children: List.generate(tutList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          //onTap: () => {_loadProductDetails(index)},
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 5,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/tutors/" +
                                      tutList[index].tutorId.toString() +
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
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Text(
                                        tutList[index].tutorName.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Email: " +
                                          tutList[index].tutorEmail.toString()),
                                      Text("Phone: " +
                                          tutList[index].tutorPhone.toString()),
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
                      color = Colors.purple;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadTutors(index + 1, "")},
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

  // Widget _createDrawerItem(
  //     {required IconData icon,
  //     required String text,
  //     required GestureTapCallback onTap}) {
  //   return ListTile(
  //     title: Row(
  //       children: <Widget>[
  //         Icon(icon),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 8.0),
  //           child: Text(text),
  //         )
  //       ],
  //     ),
  //     onTap: onTap,
  //   );
  // }

  void _loadTutors(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_tutor.php"),
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

        if (extractdata['tutors'] != null) {
          tutList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutList.add(Tutor.fromJson(v));
          });
        } else {
          titlecenter = "No Product Available";
        }
        setState(() {});
      } else {
        //do something
      }
    });
  }

  // _loadProductDetails(int index) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //           title: const Text(
  //             "Product Details",
  //             style: TextStyle(),
  //           ),
  //           content: SingleChildScrollView(
  //               child: Column(
  //             children: [
  //               CachedNetworkImage(
  //                 imageUrl: CONSTANTS.server +
  //                     "/slumshop/mobile/assets/products/" +
  //                     productList[index].productId.toString() +
  //                     '.jpg',
  //                 fit: BoxFit.cover,
  //                 width: resWidth,
  //                 placeholder: (context, url) =>
  //                     const LinearProgressIndicator(),
  //                 errorWidget: (context, url, error) => const Icon(Icons.error),
  //               ),
  //               Text(
  //                 productList[index].productName.toString(),
  //                 style: const TextStyle(
  //                     fontSize: 16, fontWeight: FontWeight.bold),
  //               ),
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //                 Text("Product Description: \n" +
  //                     productList[index].productDesc.toString()),
  //                 Text("Price: RM " +
  //                     double.parse(productList[index].productPrice.toString())
  //                         .toStringAsFixed(2)),
  //                 Text("Quantity Available: " +
  //                     productList[index].productQty.toString() +
  //                     " units"),
  //                 Text("Product Status: " +
  //                     productList[index].productStatus.toString()),
  //                 Text("Product Date: " +
  //                     df.format(DateTime.parse(
  //                         productList[index].productDate.toString()))),
  //               ]),
  //               ElevatedButton(onPressed: _addtocartDialog, child: Text("Add to cart"))
  //             ],
  //           )),
  //           actions: [
  //             TextButton(
  //               child: const Text(
  //                 "Close",
  //                 style: TextStyle(),
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  // void _loadSearchDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         // return object of type Dialog
  //         return StatefulBuilder(
  //           builder: (context, StateSetter setState) {
  //             return AlertDialog(
  //               title: const Text(
  //                 "Search ",
  //               ),
  //               content: SizedBox(
  //                 height: screenHeight / 3,
  //                 child: Column(
  //                   children: [
  //                     TextField(
  //                       controller: searchController,
  //                       decoration: InputDecoration(
  //                           labelText: 'Search',
  //                           border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(5.0))),
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Container(
  //                       height: 60,
  //                       padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
  //                       decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.grey),
  //                           borderRadius:
  //                               const BorderRadius.all(Radius.circular(5.0))),
  //                       child: DropdownButton(
  //                         value: dropdownvalue,
  //                         underline: const SizedBox(),
  //                         isExpanded: true,
  //                         icon: const Icon(Icons.keyboard_arrow_down),
  //                         items: types.map((String items) {
  //                           return DropdownMenuItem(
  //                             value: items,
  //                             child: Text(items),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String? newValue) {
  //                           setState(() {
  //                             dropdownvalue = newValue!;
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         search = searchController.text;
  //                         Navigator.of(context).pop();
  //                         _loadProducts(1, search);
  //                       },
  //                       child: const Text("Search"),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

}
