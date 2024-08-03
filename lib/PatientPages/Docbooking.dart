import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicalapp3/PatientPages/DocAppoinment.dart';

class DocBooking extends StatefulWidget {
  final String catg;
  final String username;
  const DocBooking({Key? key, required this.catg, required this.username}) : super(key: key);

  @override
  State<DocBooking> createState() => _DocBookingState();
}

class _DocBookingState extends State<DocBooking> {
  @override
  @override
  Widget build(BuildContext context) {
    String? id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors Specialized in ${widget.catg}'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Doctor")
            .where('specialization', isEqualTo: widget.catg)
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
              var doctor = snapshot.data!.docs[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    id = doctor.id;
                  });
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return DocAppoinment(docid: id.toString(),username:widget.username);
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(),
                                  child: Image(
                                    image: NetworkImage(doctor['image_url']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),SizedBox( width:
                                      MediaQuery.of(context).size.width * 0.07,),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DR ${doctor['username']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Text(
                                        '${doctor['specialization']} Specialization'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Text(
                                        '${doctor['EduQual']} Qualification '),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Text(
                                        '${doctor['Experiance']} Experiances '),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(50)),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      child: Image(
                                          image: NetworkImage(
                                              "https://cdn.iconscout.com/icon/free/png-512/free-phone-1779747-1513561.png?f=webp&w=512")),
                                    ),
                                    Text(" Book Digital Consult"),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    )
                                  ],
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    color: Color(0XFF008771),
                                    borderRadius: BorderRadius.circular(50)),
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      child: Image(
                                          image: NetworkImage(
                                              "https://cdn.iconscout.com/icon/free/png-512/free-hospital-medical-treatment-care-save-life-treat-46267.png?f=webp&w=512")),
                                    ),
                                    Text(
                                      " Book Hosplital Visit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                          ],
                        )

                        // Add more doctor details here if needed
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
