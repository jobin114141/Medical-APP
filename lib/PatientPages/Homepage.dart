import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:medicalapp3/Doctors/TodaysAppoinment.dart';
import 'package:medicalapp3/PatientPages/Specialties.dart';
import 'package:medicalapp3/PatientPages/TokenPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  String? username;
  String? image_url;
  FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    user = auth.currentUser;
    super.initState();
    UserDetails();
  }

  Future<void> UserDetails() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          
          username = documentSnapshot['username'];
          image_url = documentSnapshot['image_url'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: [
                    GFAvatar(
                      maxRadius: 25,
                      borderRadius: BorderRadius.circular(10),
                      shape: GFAvatarShape.square,
                      backgroundImage: NetworkImage("${image_url ?? ""}"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hallo, ${username} ",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 25),
                          ),
                          Text(
                            "what do you feel ?",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                                color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: InkWell(onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){return DhomePage();}));
                      },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFebebeb),
                              borderRadius: BorderRadius.circular(5)),
                          child: Image(
                              image: NetworkImage(
                                  "https://cdn.iconscout.com/icon/free/png-512/free-notification-3551877-2974232.png?f=webp&w=512")),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                              "Search Doctors, Specialists & Symptoms",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black45),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(69, 201, 199, 199),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 390, top: 13),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.035,
                            child: Center(
                              child: Image(
                                  image: NetworkImage(
                                      "https://cdn.iconscout.com/icon/premium/png-512-thumb/zoom-8941945-7298461.png?f=webp&w=512")),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0XFF008771),
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return Specialties();
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.175,
                                  height:
                                      MediaQuery.of(context).size.height * 0.077,
                                  child: Image(
                                      image: NetworkImage(
                                          "https://cdn.iconscout.com/icon/premium/png-512-thumb/calender-15-463419.png?f=webp&w=512"),fit: BoxFit.cover,),
                                ),
                                Container(
                                  child: Text(
                                    "Book",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Appoinments",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return Specialties();
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.072,
                                  child: Image(
                                      image: NetworkImage(
                                          "https://cdn.iconscout.com/icon/premium/png-512-thumb/chat-1951256-1658663.png?f=webp&w=512"),fit: BoxFit.cover,),
                                ),
                                Container(
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return TokenPage();
                              }));
                              
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Image(
                                  image: NetworkImage(
                                      "https://cdn.iconscout.com/icon/free/png-512/free-list-73-156168.png?f=webp&w=512"),fit: BoxFit.cover,),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Show",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Token",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.16,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Image(
                                    image: NetworkImage(
                                        "https://cdn.iconscout.com/icon/premium/png-512-thumb/basket-390-524411.png?f=webp&w=512"),fit: BoxFit.cover,),
                              ),
                              Container(
                                child: Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    InkWell(onTap: (){
                                      
                                    },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.16,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        child: Image(
                                            image: NetworkImage(
                                                "https://cdn.iconscout.com/icon/premium/png-512-thumb/chat-1951256-1658663.png?f=webp&w=512"),fit: BoxFit.cover,),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Digital",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "consult",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.16,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Image(
                                    image: NetworkImage(
                                        "https://cdn.iconscout.com/icon/premium/png-512-thumb/receipt-15-147761.png?f=webp&w=512"),fit: BoxFit.cover,),
                              ),
                              Container(
                                child: Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://img.freepik.com/free-vector/flat-design-healthcare-establishment-facebook-template_23-2149671669.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image(
                          image: NetworkImage(
                              "https://img.freepik.com/premium-vector/health-care-social-media-post-template_544391-490.jpg"),
                          fit: BoxFit.cover,
                        ), // Set width to 50% of the device width
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image(
                          image: NetworkImage(
                              "https://img.freepik.com/premium-photo/happy-family-day-stethoscope-paper-shape-cutout-with-father-mother-children-international-day-families-health-wellness-life-insurance-concepts_42256-7222.jpg?size=626&ext=jpg"),
                          fit: BoxFit.cover,
                        ), // Set width to 50% of the device width
                      ),
                    ),
                  ],
                ),
              ),SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "Other Services",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28,color: Color.fromARGB(197, 0, 0, 0)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: Color(0XFF7acabc),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image(
                      image: NetworkImage(
                          "https://graphicsfamily.com/wp-content/uploads/edd/2022/01/Free-Simple-Banner-Template-scaled.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: Color(0XFF7acabc),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image(
                      image: NetworkImage(
                          "https://www.discountdisplays.co.uk/assets/images/banner-frame-top-24.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Color(0XFF7acabc),
                    ),
                    child: Image(
                      image: NetworkImage(
                          "https://images-platform.99static.com/65y8kLMsLq10KpPWdjEtyHJL7t0=/0x0:1000x1000/500x500/top/smart/99designs-contests-attachments/79/79374/attachment_79374226"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
