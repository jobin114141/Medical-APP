import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  "App Store requirements regarding privacy can be found in “App Store Review Guidelines” available here and in “Apple Developer Program License Agreement” which can be found here; however, the most useful to app owners and developers are these recently published official Apple’s guidelines on privacy policies of mobile apps, which can be found here. Let’s sum up the requirements in terms of privacy policy for mobile apps and its contents.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
            ),SizedBox(height: 10,),
            Text(
                "Google Play Privacy policy for Android Apps Google Play requirements regarding privacy policy are available in “The Google Play Developer Distribution Agreement,” which can be found here and in Google’s developer Policy Center.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
          ],
        ),
      ),
    );
  }
}
