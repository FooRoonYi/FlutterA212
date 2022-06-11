import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.indigo,
        ),
        body: Column(children: [
          Flexible(
              flex: 4,
              child: Card(
                elevation: 10,
                child: Row(
                  children: const [
                    SizedBox(
                      height: 200.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
          Flexible(
              flex: 6,
              child: Column(
                children: [
                  Container(
                    child: const Center(
                      child: Text(
                        "Profile Settings",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      shrinkWrap: true,
                      children: const [
                        MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE NAME"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE PASSWORD"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE LOCATION"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("NEW REGISTRATION"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("LOGOUT"),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
