import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp3/PatientPages/BottomNavBar.dart';

class BookingConform extends StatefulWidget {
  final String TimeOfAppoinment;
  final String specialization;
  final String selectedValue;
  final String Drname;
  final String image_url;
  final String Bookingid;
  const BookingConform(
      {Key? key,
      required this.TimeOfAppoinment,
      required this.specialization,
      required this.selectedValue,
      required this.Drname,
      required this.image_url,
      required this.Bookingid})
      : super(key: key);

  @override
  State<BookingConform> createState() => _BookingConformState();
}

class _BookingConformState extends State<BookingConform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.15,
              backgroundImage: NetworkImage(widget.image_url),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            "DR.${widget.Drname}",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            "${widget.specialization} Specialist",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            "${widget.selectedValue}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          Text(
            "${widget.TimeOfAppoinment}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          Text(
            "Booking ID:${widget.Bookingid}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black38),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return BottomNavBar();
              }));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  color: Color(0XFF008771),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Confirmed",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
