import 'package:flutter/material.dart';
import 'package:medicalapp3/login/DLoginPage.dart';
import 'package:medicalapp3/login/PloginPage.dart';

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({super.key});

  @override
  State<LoginMainPage> createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 2,
                  child: Image(
                    image: NetworkImage(
                        "https://operationverve.com/wp-content/uploads/2023/05/section-1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image(
                  image: NetworkImage(
                    "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsb2ZmaWNlMV9waG90b2dyYXBoeV9vZl9hbl9zb3V0aF9pbmRpYW5fd29tZW5fYXNfYV9kb2N0b19kMzAxMDM3Zi03MDUzLTQxNDAtYmYyZS1lZDFlYWE0YTM3NDRfMS5qcGc.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Color(0xFF008771),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        "BOOK ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text("YOUR APPOINMENT",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.justify,
                            "Effortlessly book and manage doctor consultations with our clinic's dedicated app for a streamlined and patient-centric healthcare experience.",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return PLoginPage();
                              }));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  "PATIENT",
                                  style: TextStyle(
                                      color: Color(0xFF008771),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return DLoginPage();
                                }));
                              },
                              child: Center(
                                child: Text(
                                  "DOCTOR",
                                  style: TextStyle(
                                      color: Color(0xFF008771),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0114286, size.height * 0.2666667);
    path_0.lineTo(size.width * -0.0142857, size.height);
    path_0.lineTo(size.width * 0.4485714, size.height * 1.0066667);
    path_0.lineTo(size.width * 1.0028571, size.height * 1.0066667);
    path_0.lineTo(size.width * 1.0057143, size.height * 0.2666667);
    path_0.quadraticBezierTo(size.width * 0.7442857, size.height * 0.0633333,
        size.width * 0.5028571, size.height * 0.0833333);
    path_0.quadraticBezierTo(size.width * 0.2621429, size.height * 0.0650000,
        size.width * -0.0114286, size.height * 0.2666667);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
