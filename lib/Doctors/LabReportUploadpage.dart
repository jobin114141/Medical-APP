import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:image_picker/image_picker.dart';

class LabReportUploadpage extends StatefulWidget {
  final String pid;
  final String appid;
  const LabReportUploadpage({Key? key, required this.pid, required this.appid})
      : super(key: key);

  @override
  State<LabReportUploadpage> createState() => _LabReportUploadpageState();
}

class _LabReportUploadpageState extends State<LabReportUploadpage> {
  String? username;
  String? image_url;
  String? Phonenumber;
  String? location;
  String? bookingid;
  String? Email;
  bool Lab = false;
  File? selectedImage;
  File? selectedImage2;
  String? ImageUrl;
  String? ImageUrl2;
  bool? is_loading = false;
  final FirebaseStorage _Storage = FirebaseStorage.instance;
  String? status;
  void initState() {
    UserDetails();
    super.initState();
  }

  void toggleSelection() {
    setState(() {
      Lab = !Lab;
    });
  }

  Future<void> UserDetails() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.pid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          username = documentSnapshot['username'];
          image_url = documentSnapshot['image_url'];
          Phonenumber = documentSnapshot['Phonenumber'];
          location = documentSnapshot['location'];
          Email = documentSnapshot['Email'];
      
        });
      }
    });
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

  Future<void> LabImage() async {
    // this function is to accept image and dispaly it in the registraion page after uploading
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage2 = File(image.path);
      });
    }
  }

  Future<void> save2() async {
    setState(() {
      is_loading = true;
    });
    if (selectedImage2 != null) {
      final ImageRef = _Storage.ref()
          .child('prescription/${widget.pid}/${DateTime.now().toString()}.jpg');
      final ImageRef2 = _Storage.ref()
          .child('LabRepots/${widget.pid}/${DateTime.now().toString()}.jpg');

      final UploadTask uploadTask = ImageRef.putFile(selectedImage!);
      final UploadTask uploadTask2 = ImageRef2.putFile(selectedImage2!);

      final TaskSnapshot storageTaskSnapshot = await uploadTask;
      final String ImageUrltemp =
          await storageTaskSnapshot.ref.getDownloadURL();

      final TaskSnapshot storageTaskSnapshot2 = await uploadTask2;
      final String ImageUrltemp2 =
          await storageTaskSnapshot2.ref.getDownloadURL();

      setState(() {
        ImageUrl = ImageUrltemp;
        ImageUrl2 = ImageUrltemp2;
      });

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(widget.appid)
          .update({
        'prescription': ImageUrl,
        'Lab': "true",
        'status': 'complete',
        'Labreport': ImageUrl2
      });
    }
    Navigator.of(context).pop();
    setState(() {
      is_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.15,
              backgroundImage: NetworkImage(image_url ?? ""),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            "${username}",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            "PH: ${Phonenumber}",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            "Email: ${Email}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          Text(
            "location: ${location}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          Text(
            " ",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: LabImage,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF008771)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: selectedImage2 != null
                        ? GFAvatar(
                            maxRadius: 70, shape: GFAvatarShape.square,
                            backgroundImage: FileImage(
                                selectedImage2!), //displaying image to reg after uploadingt
                          )
                        : Text(
                            "Lab Image Add",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ),
              InkWell(
                onTap: getImage,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF008771)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: selectedImage != null
                        ? GFAvatar(
                            maxRadius: 70, shape: GFAvatarShape.square,
                            backgroundImage: FileImage(
                                selectedImage!), //displaying image to reg after uploadingt
                          )
                        : Text(
                            "Prescreption",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          InkWell(
            onTap: () {
              save2();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.12,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: is_loading == true
                  ? CircularProgressIndicator()
                  : Center(
                      child: Image(
                        image: NetworkImage(
                            "https://cdn.iconscout.com/icon/premium/png-512-thumb/tick-41-377261.png?f=webp&w=512"),
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
