import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LabReports extends StatefulWidget {
  const LabReports({Key? key});

  @override
  State<LabReports> createState() => _LabReportsState();
}

class _LabReportsState extends State<LabReports> {
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("appointments")
            .where("patientID", isEqualTo: user?.uid)
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
              var appointment = snapshot.data!.docs[index];
              var labReportUrl = (appointment.data() as Map<String, dynamic>?)
                          ?.containsKey('Labreport') ??
                      false
                  ? appointment['Labreport']
                  : null;
              return InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: labReportUrl != null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.31,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0XFF008771)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'Lab Report',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${appointment['Drname']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: Image(
                                          image: NetworkImage(labReportUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(), // Empty SizedBox when no lab report
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
