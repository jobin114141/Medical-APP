import 'package:flutter/material.dart';
import 'package:medicalapp3/Doctors/TodaysAppoinment.dart';
import 'package:medicalapp3/Doctors/NextdaysAppoinments.dart';
import 'package:medicalapp3/Doctors/waitingforlab.dart';
import 'package:medicalapp3/PatientPages/ProfilePages/ProfilePage.dart';

class DBottomNavBar extends StatefulWidget {
  const DBottomNavBar({Key? key});

  @override
  State<DBottomNavBar> createState() => _DBottomNavBarState();
}

class _DBottomNavBarState extends State<DBottomNavBar> {
  int currentIndex = 0;

  final List<Widget> otherPages = [
    DhomePage(),
    WaitingForLab(),
    otherAppoinments(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF008771),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.network(
              'https://cdn.iconscout.com/icon/premium/png-512-thumb/today-1922630-1630563.png?f=webp&w=512', // Replace this with your image URL
              width: 24, // Set width as per your requirement
              height: 24, // Set height as per your requirement
            ),
            label: "Todays Visits",
          ),
          BottomNavigationBarItem(
            icon: Image.network(
              'https://cdn.iconscout.com/icon/premium/png-256-thumb/medical-lab-1966494-1665220.png?f=webp&w=256', // Replace this with your image URL
              width: 24, // Set width as per your requirement
              height: 24, // Set height as per your requirement
            ),
            label: "Lab upload",
          ),
          BottomNavigationBarItem(
            icon: Image.network(
              'https://cdn.iconscout.com/icon/premium/png-512-thumb/meeting-calendar-10857700-8926583.png?f=webp&w=512', // Replace this with your image URL
              width: 24, // Set width as per your requirement
              height: 24, // Set height as per your requirement
            ),
            label: "Future Slots",
          ),
          BottomNavigationBarItem(
            icon: Image.network(
              'https://cdn.iconscout.com/icon/premium/png-512-thumb/avatar-2879046-2393874.png?f=webp&w=512', // Replace this with your image URL
              width: 24, // Set width as per your requirement
              height: 24, // Set height as per your requirement
            ),
            label: "Profile",
          )
        ],
      ),
      body: otherPages[currentIndex],
    );
  }
}
