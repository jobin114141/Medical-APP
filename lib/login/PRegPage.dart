import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp3/login/PloginPage.dart';

class PRegPage extends StatefulWidget {
  const PRegPage({super.key});

  @override
  State<PRegPage> createState() => _PRegPageState();
}

class _PRegPageState extends State<PRegPage> {
  File? selectedImage;
  TextEditingController regUserName = TextEditingController();
  TextEditingController regEmilid = TextEditingController();
  TextEditingController regPhonenumber = TextEditingController();
  TextEditingController regPassword = TextEditingController();
  TextEditingController regLocattion = TextEditingController();
  bool loading = false;
  String? ImageUrl;
  final FirebaseStorage _Storage = FirebaseStorage.instance;
  Future<void> _userRegistration() async {
    try {
      setState(() {
        loading = true;
      });

      // user creation through email
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: regEmilid.text, password: regPassword.text);
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
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "username": regUserName.text,
          "Email": regEmilid.text,
          "location": regLocattion.text,
          "Phonenumber": regPhonenumber.text,
          'image_url': ImageUrl, //saving image link to user db
        });
        //after login go to login screen
        setState(() {
          loading = false;
        });

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return PLoginPage();
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
                      border: OutlineInputBorder(), hintText: "FULL NAME"),
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
                  controller: regPhonenumber,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Phone number"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  controller: regPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Password"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  controller: regLocattion,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Location"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF008771)),
                  child: InkWell(
                    onTap: () {
                       _userRegistration();
                    },
                    child: Center(
                        child: loading != false
                    ? CircularProgressIndicator():Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
