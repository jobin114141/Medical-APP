import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalapp3/Doctors/ViewAppoinmnetPage.dart';

class DhomePage extends StatefulWidget {
  const DhomePage({super.key});

  @override
  State<DhomePage> createState() => _DhomePageState();
}

class _DhomePageState extends State<DhomePage> {
  User? user;
  String? Drname;
  String? image_url;
  String? Bookkingid;
  String? EduQual;
  String? Experiance;
  String? specialization;
  DateTime now = DateTime.now();
  late String formattedDateToday;
  List<String> appointments = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    user = auth.currentUser;
    now = DateTime.now();
    formattedDateToday = DateFormat('EEEE, MMMM d').format(now);
    DocDetails();
    super.initState();
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
          Bookkingid=documentSnapshot['BookingId'];
        });
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text("Today Appoinments")],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("appointments")
            .where("doctorID", isEqualTo: user?.uid)
            .where("date", isEqualTo: formattedDateToday)
            .where("Lab", isEqualTo:"false")
            .where("status", isEqualTo:"booked")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => SizedBox(),
            itemBuilder: (context, index) {
              var Appointment = snapshot.data!.docs[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return AppoinmnetViewPage(pid:Appointment['patientID'],appid:Appointment.id.toString());
                  }));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.21,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Color(0XFF008771))),
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${Appointment['date'].split(',')[1].trim()}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    2), // Add some space between the day and month
                                            Text(
                                              "${Appointment['date'].split(',')[0]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.17,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      decoration: BoxDecoration(
                                          color: (Color(0XFF008771))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${Appointment['Pname']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        'Booking ID:${Appointment['BookingId']}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        '${Appointment['time']}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
