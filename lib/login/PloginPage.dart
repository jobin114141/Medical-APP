import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicalapp3/AuthProvider.dart';
import 'package:medicalapp3/PatientPages/BottomNavBar.dart';
import 'package:medicalapp3/login/PRegPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PLoginPage extends StatefulWidget {
  const PLoginPage({super.key});

  @override
  State<PLoginPage> createState() => _PLoginPageState();
}

class _PLoginPageState extends State<PLoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  bool is_loading = false;
  signin(BuildContext context) async {
    setState(() {
      is_loading = true;
    });
    try {
      /* loading.value = true; */
      await auth.signInWithEmailAndPassword(
          email: loginemail.text, password: loginpassword.text);
      MyAuthProvider().setUserType('patient');
      Shrdprfs();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => BottomNavBar()));
      /* loading.value = false; */
    } catch (e) {
      setState(() {
        is_loading = false;
      });
    }
    setState(() {
      is_loading = false;
    });
  }

  Shrdprfs() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("email", loginemail.text);
    sharedPreferences.setString("userType", 'patient');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/5878481/pexels-photo-5878481.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                TextField(
                  controller: loginemail,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: "Email"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextField(
                  controller: loginpassword,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: "Password"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    signin(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF008771)),
                    child: Center(
                        child: is_loading == true
                            ? CircularProgressIndicator()
                            : Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              )),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return PRegPage();
                      }));
                    },
                    child: Text("dont have an account?"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
