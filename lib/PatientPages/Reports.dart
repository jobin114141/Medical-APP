import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:medicalapp3/PatientPages/LabReports.dart';
import 'package:medicalapp3/PatientPages/PrescriptionPage.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  late Future<List<DocumentSnapshot>> _futureAppointments;
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    _futureAppointments = _fetchAppointmentDetails();
  }

  Future<List<DocumentSnapshot>> _fetchAppointmentDetails() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('patientID', isEqualTo: user?.uid)
        .where('status', isEqualTo: "complete")
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text("Health Records ")],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0XFF008771)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return PrescriptionPage();
                          }));
                        },
                        child: Container(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                "https://cdn.iconscout.com/icon/premium/png-512-thumb/prescription-83-332067.png?f=webp&w=512"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Prescription",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
                              return LabReports();
                            }));
                          },
                          child: Container(
                              child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                "https://cdn.iconscout.com/icon/premium/png-256-thumb/electron-report-3191355-2659288.png?f=webp&w=256"),
                          ))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Lab Report",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Container(
                              child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                "https://cdn.iconscout.com/icon/premium/png-256-thumb/bill-5207093-4344836.png?f=webp&w=256"),
                          ))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Bill History",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _futureAppointments,
              builder:
                  (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<DocumentSnapshot> appointmentDocs = snapshot.data!;
                  if (appointmentDocs.isEmpty) {
                    return Text('No appointment data found.');
                  } else {
                    return ListView.builder(
                      itemCount: appointmentDocs.length,
                      itemBuilder: (context, index) {
                        var appointmentData = appointmentDocs[index].data()
                            as Map<String, dynamic>;
                        var doctorName = appointmentData['Drname'];
                        var specialization = appointmentData['specialization'];
                        var date = appointmentData['date'];
                        var img = appointmentData['prescription'];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Doctor: $doctorName',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'Specialization: $specialization',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    'Date: $date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.19,
                                      child: Image(
                                        image: NetworkImage(img),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    );
                  }
                } else {
                  return Text('No appointment data found.');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
