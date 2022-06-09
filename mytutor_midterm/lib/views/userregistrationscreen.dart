import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor_midterm/views/loginscreen.dart';

import '../constant.dart';
import '../models/user.dart';

class UserResgisterScreen extends StatefulWidget {
  const UserResgisterScreen({Key? key}) : super(key: key);

  @override
  State<UserResgisterScreen> createState() => _UserResgisterScreenState();
}

class _UserResgisterScreenState extends State<UserResgisterScreen> {
  late double screenHeight, screenWidth, regWidth;
  var _image;
  var pathAsset = "assets/images/tutor.png";
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passEditingController = TextEditingController();
  final TextEditingController pass2EditingController = TextEditingController();
  final TextEditingController phoneNoEditingController =
      TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      regWidth = screenWidth;
    } else {
      regWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: regWidth,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(children: [
                  const SizedBox(height: 10),
                  Card(
                    child: GestureDetector(
                        onTap: () => {_takePictureDialog()},
                        child: SizedBox(
                            height: screenHeight / 4.0,
                            width: screenWidth,
                            child: _image == null
                                ? Image.asset(pathAsset)
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ))),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "Username must be longer than 3"
                          : null,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus);
                      },
                      controller: nameEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(),
                          icon: Icon(
                            Icons.person,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ))),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "User email must be longer than 3"
                          : null,
                      focusNode: focus1,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus1);
                      },
                      controller: emailEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(),
                          icon: Icon(
                            Icons.add_link_rounded,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ))),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "User password must be longer than 3"
                          : null,
                      focusNode: focus2,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus2);
                      },
                      controller: passEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(),
                          icon: Icon(
                            Icons.add_chart_rounded,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ))),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter your password correctly';
                      }
                      return null;
                    },
                    controller: pass2EditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Re-enter Password",
                        icon: Icon(
                          Icons.add_chart_rounded,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0))),
                  ),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty
                          ? "Phone Number must contain value"
                          : null,
                      focusNode: focus3,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus3);
                      },
                      controller: phoneNoEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(),
                          icon: Icon(
                            Icons.phone,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ))),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "User address must be filled in"
                          : null,
                      focusNode: focus4,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus4);
                      },
                      controller: addressEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Address',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(),
                          icon: Icon(
                            Icons.home,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ))),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo.shade400,
                        fixedSize: Size(regWidth / 2, regWidth * 0.1)),
                    child: const Text('Register now!'),
                    onPressed: () => {
                      _registerUserDialog(),
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already Register? ",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()))
                        },
                        child: const Text(
                          "Login here",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _selectfromGallery(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _selectFromCamera()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  _registerUserDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "Please take the your picture",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register New Account",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                _AddUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _AddUser() {
    String _name = nameEditingController.text;
    String _email = emailEditingController.text;
    String _password = passEditingController.text;
    String _phone = phoneNoEditingController.text;
    String _address = addressEditingController.text;
    String base64image = base64Encode(_image!.readAsBytesSync());
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.post(
          Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/user_reg.php"),
          body: {
            "name": _name,
            "email": _email,
            "password": _password,
            "phoneNo": _phone,
            "address": _address,
            "image": base64image,
          }).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          User user = User.fromJson(data['data']);
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const LoginScreen()));
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      });
    }
  }
}
