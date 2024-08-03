import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:medicalapp3/PatientPages/LabReports.dart';
import 'package:medicalapp3/PatientPages/ProfilePages/HelpPage.dart';
import 'package:medicalapp3/PatientPages/ProfilePages/PrivacyPage.dart';
import 'package:medicalapp3/PatientPages/ProfilePages/ProfileEditpage.dart';
import 'package:medicalapp3/PatientPages/Reports.dart';
import 'package:medicalapp3/login/Loginmainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DProfilePage extends StatefulWidget {
  const DProfilePage({super.key});

  @override
  State<DProfilePage> createState() => _DProfilePageState();
}

class _DProfilePageState extends State<DProfilePage> {
  User? user;
  String? username;
  String? image_url;
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    user = auth.currentUser;
    print(user?.uid);
    UserDetails();
    super.initState();
  }

  signout(BuildContext context) async {
    await auth.signOut();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove("email");
    sharedPreferences.remove("userType");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => LoginMainPage()));
  }

  Future<void> UserDetails() async {
    print("+++++++++++++++++");
    FirebaseFirestore.instance
        .collection("Doctor")
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          username = documentSnapshot['username'];
          print(username);
          image_url = documentSnapshot['image_url'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0XFF008771)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "${username ?? ""}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(" ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8)),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return ProfileEditPage();
                            }));
                          },
                          child: GFAvatar(
                            maxRadius: 25,
                            borderRadius: BorderRadius.circular(10),
                            shape: GFAvatarShape.square,
                            backgroundImage: NetworkImage("${image_url ?? ""}"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return ProfileEditPage();
                            }));
                          },
                          child: Text(
                            "Manage Profile",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return LabReports();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0XFF008771),
                    )),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(0, 249, 249, 249),
                        backgroundImage: NetworkImage(
                            "https://cdn.iconscout.com/icon/premium/png-256-thumb/data-research-9393761-7653946.png?f=webp&w=256"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Lab Test And Doctor Consultings",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Order History And Transaction",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return Reports();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0XFF008771),
                    )),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(0, 253, 253, 253),
                        backgroundImage: NetworkImage(
                            "https://cdn.iconscout.com/icon/premium/png-256-thumb/badge-10147007-8241748.png?f=webp&w=256"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "All Health Records",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Report,Presentation,Bill & More",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "More",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0XFF008771),
                  )),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      child: Image(
                        image: NetworkImage(
                            "https://cdn.iconscout.com/icon/free/png-512/free-help-118-433762.png?f=webp&w=512"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return HelpPage();
                        }));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Help",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("FAQ,get helpm  or raise a query",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0XFF008771),
                  )),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      child: Image(
                        image: NetworkImage(
                            "https://cdn.iconscout.com/icon/premium/png-512-thumb/finger-print-3305777-2775777.png?f=webp&w=512"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Privacy();
                        }));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Privacy & Policy",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Data issues, Privacy Concerns",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0XFF008771),
                  )),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(0, 249, 248, 248),
                      backgroundImage: NetworkImage(
                          "https://cdn.iconscout.com/icon/premium/png-256-thumb/about-us-6563042-5414144.png?f=webp&w=256"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "About Us",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Order History And Transcations",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w300))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                signout(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Log out",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Log out from this mobile",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w300))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
