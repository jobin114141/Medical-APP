import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicalapp3/PatientPages/BottomNavBar.dart';
import 'package:medicalapp3/login/Loginmainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
     
      Timer(Duration(seconds: 2), () {
        if (finalEmail == null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return LoginMainPage();
          }));
        } else { 
           {
          print("0000000000000000000000000000000000000000");
          print(finalUserType);
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return BottomNavBar();
            }));
          }
        }
      });
    });
    super.initState();
  }

  String? finalEmail;
  String? finalUserType; // Add a variable to store user type

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");
    var obtainedUserType = sharedPreferences.getString("userType"); // Retrieve user type from SharedPreferences
    setState(() {
      finalEmail = obtainedEmail;
      finalUserType = obtainedUserType; // Set user type to state variable
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color:Colors.red)
          ],
        ),
      ),
    );
  }
}
