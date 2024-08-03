import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  late Future<DocumentSnapshot> _futureAppointment;

  @override
  void initState() {
    super.initState();
    _futureAppointment = _fetchAppointmentDetails();
  }

  Future<DocumentSnapshot> _fetchAppointmentDetails() async {
    // Assuming you have a way to identify the appointment to fetch, replace 'yourAppointmentId' with the actual appointment ID
    return FirebaseFirestore.instance.collection('appointments').doc().get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Records"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: _futureAppointment,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  var appointmentData = snapshot.data!.data() as Map<String, dynamic>; // Explicitly cast to Map<String, dynamic>
                  // Extract appointment details from appointmentData
                  var doctorName = appointmentData['Drname'];
                  var specialization = appointmentData['specialization'];
                  var date = appointmentData['date'];
                  var time = appointmentData['time'];
                  // Display appointment details
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFF008771),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Doctor: $doctorName'),
                            Text('Specialization: $specialization'),
                            Text('Date: $date'),
                            Text('Time: $time'),
                          ],
                        ),
                      ],
                    ),
                  );
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
