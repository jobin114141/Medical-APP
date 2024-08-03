import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp3/login/DLoginPage.dart';

class DRegPage extends StatefulWidget {
  const DRegPage({super.key});

  @override
  State<DRegPage> createState() => _DRegPageState();
}

class _DRegPageState extends State<DRegPage> {
  List<String> list = ['Physcian', 'paediatrics', 'Gynaecologyican', 'Eye','Orthopaedics','ENT'];
  String dropdownValue = '';
  List<String> list2 = ['MD', 'MBBS'];
  String dropdownValue2 = '';
  @override
  void initState() {
    super.initState();
    dropdownValue = list.isNotEmpty ? list.first : ''; // Set dropdownValue here
    dropdownValue2 = list2.isNotEmpty ? list2.first : ''; // Set dropdownValue here
  }

  File? selectedImage;
  TextEditingController regUserName = TextEditingController();
  TextEditingController regEmilid = TextEditingController();
  TextEditingController specialization = TextEditingController();
  TextEditingController regPassword = TextEditingController();
  TextEditingController EduQual = TextEditingController();
  TextEditingController Experiance = TextEditingController();

  bool loading = false;
  String? ImageUrl;
  final FirebaseStorage _Storage = FirebaseStorage.instance;
  Future<void> _DocRegistration() async {
    try {
      setState(() {
        loading = true;
      });

      // user creation through email
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: regEmilid.text, password: regPassword.text);
        await userCredential.user!.updateDisplayName("DR");
      if (selectedImage != null) {
        final ImageRef = _Storage.ref().child(
            'user_image/${userCredential.user!.uid}.jpg'); //saving image to firebase storage in user_image folder as userid.jpg
        final UploadTask uploadTask = ImageRef.putFile(selectedImage!);
        final TaskSnapshot storageTaskSnapshot = await uploadTask;
        final String ImageUrltemp = await storageTaskSnapshot.ref
            .getDownloadURL(); // save chyitha image inte url downloding to put it in user db
        setState(() {
          ImageUrl =
              ImageUrltemp; //image saved int url setting to this variable
        });
      }
      if (userCredential.user != null) {
        // Save user details to Firestore
        await FirebaseFirestore.instance
            .collection("Doctor")
            .doc(userCredential.user!.uid)
            .set({
          "username": regUserName.text,
          "Email": regEmilid.text,
          "specialization": dropdownValue,
          "EduQual": dropdownValue2,
          "Experiance": Experiance.text,
          'image_url': ImageUrl, //saving image link to user db
        });
        //after login go to login screen
        setState(() {
          loading = false;
        });

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return DLoginPage();
        }));
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      print("Registration Error: ${e.toString()}");
    }
  }

  Future<void> getImage() async {
    // this function is to accept image and dispaly it in the registraion page after uploading
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: selectedImage != null
                          ? CircleAvatar(
                              maxRadius: 40,
                              backgroundImage: FileImage(
                                  selectedImage!), //displaying image to reg after uploadingt
                            )
                          : CircleAvatar(
                              maxRadius: 40,
                              backgroundColor:
                                  const Color.fromARGB(255, 207, 206, 206),
                              child: Icon(
                                Icons.person_add_alt,
                                size: 50,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: regUserName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "NAME"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: regEmilid,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Email"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: Experiance,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Experiance in years"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [Text("Specializatation in :  "),
                      DropdownMenu<String>(
                        initialSelection: list.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries:
                            list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                    ],
                  ),
                 
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),Row(
                    children: [Text("Education Qualification :  "),
                      DropdownMenu<String>(
                        initialSelection: list2.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue2 = value!;
                          });
                        },
                        dropdownMenuEntries:
                            list2.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                    ],
                  ),
                 
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: regPassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Password"),
                  ), SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF008771)),
                    child: InkWell(
                      onTap: () {
                        _DocRegistration();
                      },
                      child: Center(
                          child: loading != false
                              ? CircularProgressIndicator()
                              : Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
