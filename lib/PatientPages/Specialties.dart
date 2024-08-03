import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp3/PatientPages/Docbooking.dart';

class Specialties extends StatefulWidget {
  const Specialties({super.key});

  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  User? user;
  String? username;
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
                  children: [],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
             Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                              child: Text(
                            "Search Doctors, Specialists & Symptoms",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black45),
                          )),
                          decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(37, 0, 0, 0)),
                              color: Color.fromARGB(69, 201, 199, 199),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 390, top: 18),
                          child: Icon(Icons.search),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.26,
                            height: MediaQuery.of(context).size.height * 0.14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0XFF008771))),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return DocBooking(
                                    catg: "Physcian",username:username.toString()
                                  );
                                }));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Center(
                                      child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                        child: Container(decoration: BoxDecoration(),
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.18,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.07,
                                          child: Image(
                                            image: NetworkImage(
                                                "https://thefamilytreehospital.com/wp-content/uploads/sites/13/2023/08/general-physician-1.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text("General",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  Container(
                                    child: Text(
                                      "Physcian",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return DocBooking(
                                  catg: "paediatrics",username:username.toString()
                                );
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Color(0XFF008771))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://bhandarihospital.net/wp-content/uploads/2021/11/Paediatrics-img.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text("Paediatrics",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Container(
                                        child: Text(
                                          "Appoinments",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return DocBooking(
                                  catg: "Gynaecologyican",username:username.toString()
                                );
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Color(0XFF008771))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://drdeepika.com/wp-content/uploads/2023/11/Gynecologist-in-Noida.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text("Gynaecologyican",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Container(
                                        child: Text(
                                          "Appoinments",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.26,
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border:
                                        Border.all(color: Color(0XFF008771))),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return DocBooking(
                                        catg: "Eye",username:username.toString()
                                      );
                                    }));
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://www.nvisioncenters.com/wp-content/uploads/types-of-eye-care-professionals.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text("Eye",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Container(
                                        child: Text(
                                          "Specialist",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return DocBooking(
                                  catg: "Orthopaedics",username:username.toString()
                                );
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Color(0XFF008771))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW6Nr9DQBDjcqYU1TJeGwjS7LA8V4EIcjBK6nZdqDbeQ&s"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text("Orthopaedics",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Container(
                                        child: Text(
                                          "Appoinments",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                                return DocBooking(
                                  catg: "ENT",username:username.toString()
                                );
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Color(0XFF008771))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRahm4Z1Nt3jh5nDX_2nx31_sNfRLzgf5C75PMtv8KoPg&s"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text("ENT",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Container(
                                        child: Text(
                                          "Appoinments",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Personal Wellness",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 25),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "view all  >",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.47,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0XFF008771))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Image(
                                    image: NetworkImage(
                                        "https://cdn.iconscout.com/icon/premium/png-512-thumb/brain-1807873-1535129.png?f=webp&w=512"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text("Psychiatry",
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.47,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0XFF008771))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Image(
                                    image: NetworkImage(
                                        "https://cdn.iconscout.com/icon/free/png-512/free-sexual-reproductive-health-5136416-4285369.png?f=webp&w=512"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text("Sexual Health",
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Brows by Symptom",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 25),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "view all >",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),SizedBox(height: 10,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-512/free-sore-throat-1800375-1524702.png?f=webp&w=512"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Throat Pain",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-512/free-runny-nose-2390384-1994347.png?f=webp&w=512"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Runny Nose",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-512/free-headache-1773219-1508534.png?f=webp&w=512"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Migrain",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/free-cough-2390398-1994358.png?f=webp&w=256"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Cough",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-512/free-sore-throat-1800375-1524702.png?f=webp&w=512"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Throat Pain",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-512/free-runny-nose-2390384-1994347.png?f=webp&w=512"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Runny Nose",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-512/free-headache-1773219-1508534.png?f=webp&w=512"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Migrain",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0XFF008771))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      height:
                                          MediaQuery.of(context).size.height * 0.06,
                                      child: Image(image: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/free-cough-2390398-1994358.png?f=webp&w=256"),fit: BoxFit.cover,),
                                    ),
                                  ),SizedBox(height: 10,),
                                  Container(
                                    child: Text("Cough",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
