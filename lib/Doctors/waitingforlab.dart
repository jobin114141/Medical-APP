import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp3/Doctors/LabReportUploadpage.dart';

class WaitingForLab extends StatefulWidget {
  const WaitingForLab({super.key});

  @override
  State<WaitingForLab> createState() => _WaitingForLabState();
}

class _WaitingForLabState extends State<WaitingForLab> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  void initState() {
    user = auth.currentUser;
    print(user?.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text("Lab Report")],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("appointments")
            .where("doctorID", isEqualTo: user?.uid)
            .where("Lab", isEqualTo: "true")
            .where("status", isEqualTo: "waitingforlabresult")
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
                    return LabReportUploadpage(
                        pid: Appointment['patientID'],
                        appid: Appointment.id.toString());
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
                                        'Booking ID: ${Appointment['BookingId']}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        '${Appointment['time']} to ${Appointment['time']}',
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
