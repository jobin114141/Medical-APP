import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  var Status = "Upcoming";
  User? user;
  late String formattedDate;
  DateTime now = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    user = auth.currentUser;
    now = DateTime.now();
    formattedDate = DateFormat('EEEE, MMMM d').format(now);
    print(formattedDate);
    super.initState();
  }

  void handleContainerTap(String value) {
    setState(() {
      Status = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        color: Color(0XFFb8b8b8),
                        borderRadius: BorderRadius.circular(80)),
                  ),
                  InkWell(
                    onTap: () {
                      handleContainerTap("Upcoming");
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Upcoming",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Status == "Upcoming"
                              ? Color(0XFF008771)
                              : Color(0Xffb8b8b8),
                          borderRadius: BorderRadius.circular(80)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130),
                    child: InkWell(
                        onTap: () {
                          handleContainerTap("complete");
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "complete",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )),
                          width: MediaQuery.of(context).size.width * 0.31,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: Status == "complete"
                                  ? Color(0XFF008771)
                                  : Color(0Xffb8b8b8),
                              borderRadius: BorderRadius.circular(80)),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 270),
                    child: InkWell(
                      onTap: () {
                        handleContainerTap("Cancelled");
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "Cancelled",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Status == "Cancelled"
                                ? Color(0XFF008771)
                                : Color(0Xffb8b8b8),
                            borderRadius: BorderRadius.circular(80)),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("appointments")
            .where('patientID', isEqualTo: user?.uid)
            .where('status', isEqualTo: getStatusValue(Status))
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
                onTap: () {},
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
                                        'DR ${Appointment['Drname']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        '${Appointment['specialization']} specialization',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        'Booking ID: ${Appointment['BookingId']}',
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
                            InkWell(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('appointments')
                                      .doc(Appointment.id)
                                      .update({'status': 'cancelled'});
                                },
                                child: Status == "Upcoming"
                                    ? Center(child: Text("CANCEL",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w700),))
                                    : SizedBox()),
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

  String getStatusValue(String status) {
    switch (status) {
      case "Upcoming":
        return "booked";
      case "complete":
        return "complete";
      case "Cancelled":
        return "cancelled";
      default:
        return "booked"; // Default to 'booked' if status is not recognized
    }
  }
}
