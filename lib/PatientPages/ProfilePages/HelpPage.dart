import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Frequently Asked Question",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),)),
            SizedBox(height: 10,),
            Text("Who can use an FAQ templete?",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w300) ,),
            SizedBox(height: 10,),
            Text("Why use an FAQ templete",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300),)
          ],
        ),
      ),
    );
  }
}
