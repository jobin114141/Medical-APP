import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:intl/intl.dart';

class otherAppoinments extends StatefulWidget {
  const otherAppoinments({super.key});

  @override
  State<otherAppoinments> createState() => _otherAppoinmentsState();
}

class _otherAppoinmentsState extends State<otherAppoinments> {
  String? selectedValue;
  bool isLoading = true;
  late String formattedDate;
  late String formattedDatetomorrow;
  late String formattedDateDayAfterTomorrow;
  DateTime now = DateTime.now();
  String? TimeOfAppoinment;
  User? user;
  String? Drname;
  String? image_url;
  String? EduQual;
  String? Experiance;
  String? specialization;
  List<String> appointments = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    now = DateTime.now();
    formattedDate = DateFormat('EEEE, MMMM d').format(now);
    DateTime tomorrow = now.add(Duration(days: 1));
    formattedDatetomorrow = DateFormat('EEEE, MMMM d').format(tomorrow);
    DateTime dayAfterTomorrow = now.add(Duration(days: 2));
    formattedDateDayAfterTomorrow =
        DateFormat('EEEE, MMMM d').format(dayAfterTomorrow);
    selectedValue = formattedDate; // Initially select today's date
    // Fetch appointments for the selected date
    DocDetails();
  }

  void handleContainerTap(String value) {
    setState(() {
      selectedValue = value;
      appointments.clear(); // Clear existing appointments
      isLoading = true; // Set loading state while fetching new appointments
    });
    // Fetch appointments for the selected date
    DocDetails();
  }

  Future<void> DocDetails() async {
    FirebaseFirestore.instance
        .collection("Doctor")
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          Drname = documentSnapshot['username'];
          EduQual = documentSnapshot['EduQual'];
          Experiance = documentSnapshot['Experiance'];
          specialization = documentSnapshot['specialization'];
          image_url = documentSnapshot['image_url'];
        });
      }
    });

    // Fetch appointments for the selected date
    await FirebaseFirestore.instance
        .collection("appointments")
        .where("doctorID", isEqualTo: user?.uid)
        .where("date", isEqualTo: selectedValue)
        .where("status", isEqualTo: "booked")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          appointments.add(doc['time']);
        });
      });
    });

    setState(() {
      isLoading =
          false; // Set loading state to false after appointments are fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Doctor Details
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0XFF008771))),
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(),
                            child: GFAvatar(
                              maxRadius: 45,
                              borderRadius: BorderRadius.circular(10),
                              shape: GFAvatarShape.square,
                              backgroundImage: NetworkImage(image_url ?? ""),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DR ${Drname ?? ""}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                'Specialization ${specialization ?? ""}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text('Qualification ${EduQual ?? ""}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text('Experiances ${Experiance ?? ""}'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Date Selection
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: selectedValue == formattedDate
                            ? Color(0XFF008771)
                            : const Color.fromARGB(255, 253, 253, 253),
                        border: Border.all(color: Color(0XFF008771)),
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () => handleContainerTap(formattedDate),
                      child: Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          " ${formattedDate}\n Today",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: selectedValue == formattedDatetomorrow
                            ? Color(0XFF008771)
                            : const Color.fromARGB(255, 253, 253, 253),
                        border: Border.all(color: Color(0XFF008771)),
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () => handleContainerTap(formattedDatetomorrow),
                      child: Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(formattedDatetomorrow,
                            style: TextStyle(fontSize: 10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: selectedValue == formattedDateDayAfterTomorrow
                            ? Color(0XFF008771)
                            : const Color.fromARGB(255, 253, 253, 253),
                        border: Border.all(color: Color(0XFF008771)),
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () =>
                          handleContainerTap(formattedDateDayAfterTomorrow),
                      child: Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(formattedDateDayAfterTomorrow,
                            style: TextStyle(fontSize: 10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Time Slots
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0XFF008771))),
              padding: EdgeInsets.all(8.0),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Select Schedule Time",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 180,
                          width: 300,
                          child: GridView.count(
                            crossAxisCount: 4,
                            children: List<Widget>.generate(8, (index) {
                              int hour = 10 + index; // Start from 10 AM
                              String time = hour > 12
                                  ? '${hour - 12}:00 PM'
                                  : '$hour:00 AM';
                              Color color;
                              if (TimeOfAppoinment == time) {
                                color = Color.fromARGB(255, 0, 135, 112);
                              } else {
                                color = appointments.contains(time)
                                    ? Color(0XFF008771)
                                    : Color.fromARGB(255, 255, 255, 255);
                              }
                              return InkWell(
                                onTap: () {
                                  setState(() {});
                                },
                                child: GridTile(
                                  child: SizedBox(
                                    height: 20,
                                    child: Card(
                                      color: color,
                                      child: Center(
                                        child: Text(
                                          time,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
            ),

            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.58,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0XFF008771)),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Image(
                        image: NetworkImage(
                            "https://cdn.iconscout.com/icon/free/png-512/free-hospital-861-1147689.png?f=webp&w=512")),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "For more information please call",
                          style: TextStyle(
                              color: Color(0XFF008771),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "+91-8111949621",
                        style: TextStyle(
                            color: Color(0XFF008771),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
