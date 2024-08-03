import 'package:flutter/material.dart';
import 'package:medicalapp3/Doctors/DProfilePage.dart';
import 'package:medicalapp3/PatientPages/Homepage.dart';
import 'package:medicalapp3/PatientPages/ProfilePages/ProfilePage.dart';
import 'package:medicalapp3/PatientPages/Reports.dart';
import 'package:medicalapp3/PatientPages/Specialties.dart';
import 'package:medicalapp3/Doctors/DHomePage.dart';
import 'package:medicalapp3/Doctors/NextdaysAppoinments.dart';
import 'package:medicalapp3/Doctors/waitingforlab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  final List<Widget> patientPages = [
    HomePage(),
    Specialties(),
    Reports(),
    ProfilePage(),
  ];

  final List<BottomNavigationBarItem> patientBottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-256-thumb/home-1803312-1530252.png?f=webp&w=256',
        width: 24,
        height: 24,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-256-thumb/specialist-1730569-1473141.png?f=webp&w=256',
        width: 24,
        height: 24,
      ),
      label: "Specialists",
    ),
    BottomNavigationBarItem(icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-256-thumb/reports-26-641735.png?f=webp&w=256',
        width: 24,
        height: 24,
      ),
      label: "Reports",),
    BottomNavigationBarItem(icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-512-thumb/profile-4119331-3417744.png?f=webp&w=512',
        width: 24,
        height: 24,
      ),
      label: "Profile",),
  ];

  final List<Widget> doctorPages = [
    DHomePage(),
    WaitingForLab(),
    otherAppoinments(),
    DProfilePage()
  ];

  final List<BottomNavigationBarItem> doctorBottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-512-thumb/today-1922630-1630563.png?f=webp&w=512',
        width: 24,
        height: 24,
      ),
      label: "Todays Visits",
    ),
    BottomNavigationBarItem(
      icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-256-thumb/medical-lab-1966494-1665220.png?f=webp&w=256',
        width: 24,
        height: 24,
      ),
      label: "Lab upload",
    ),
    BottomNavigationBarItem(
      icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-512-thumb/meeting-calendar-10857700-8926583.png?f=webp&w=512',
        width: 24,
        height: 24,
      ),
      label: "Future Slots",
    ),
    BottomNavigationBarItem(
      icon: Image.network(
        'https://cdn.iconscout.com/icon/premium/png-512-thumb/avatar-2879046-2393874.png?f=webp&w=512',
        width: 24,
        height: 24,
      ),
      label: "Profile",
    )
  ];

  late List<BottomNavigationBarItem> bottomNavBarItemsToShow;

  @override
  void initState() {
    super.initState();
    getUserTypeAndSetPages();
  }

  Future<void> getUserTypeAndSetPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? finalUserType = prefs.getString('userType');
    setState(() {
      if (finalUserType == 'patient') {
        bottomNavBarItemsToShow = patientBottomNavBarItems;
      } else {
        bottomNavBarItemsToShow = doctorBottomNavBarItems;
      }
    });
  }

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
        items: bottomNavBarItemsToShow,
      ),
      body: bottomNavBarItemsToShow == patientBottomNavBarItems
          ? patientPages[currentIndex]
          : doctorPages[currentIndex],
    );
  }
}
