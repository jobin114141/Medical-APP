import 'package:flutter/material.dart';
import 'package:medicalapp3/Doctors/TodaysAppoinment.dart';
import 'package:medicalapp3/Doctors/waitingforlab.dart';

class DHomePage extends StatefulWidget {
  const DHomePage({super.key});

  @override
  State<DHomePage> createState() => _DHomePageState();
}

class _DHomePageState extends State<DHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFF008771)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return DhomePage();
                            }));
                          },
                          child: Container(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://cdn.iconscout.com/icon/premium/png-512-thumb/today-1922630-1630563.png?f=webp&w=512"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Appoinmens",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return WaitingForLab();
                              }));
                            },
                            child: Container(
                                child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://cdn.iconscout.com/icon/premium/png-512-thumb/laboratory-60-330373.png?f=webp&w=512"),
                            ))),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Lab Reports",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Container(
                                child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://cdn.iconscout.com/icon/premium/png-256-thumb/bill-5207093-4344836.png?f=webp&w=256"),
                            ))),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Bill History",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),              Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://img.freepik.com/free-vector/flat-design-healthcare-establishment-facebook-template_23-2149671669.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Image(
                            image: NetworkImage(
                                "https://img.freepik.com/premium-vector/health-care-social-media-post-template_544391-490.jpg"),
                            fit: BoxFit.cover,
                          ), // Set width to 50% of the device width
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Image(
                            image: NetworkImage(
                                "https://img.freepik.com/premium-photo/happy-family-day-stethoscope-paper-shape-cutout-with-father-mother-children-international-day-families-health-wellness-life-insurance-concepts_42256-7222.jpg?size=626&ext=jpg"),
                            fit: BoxFit.cover,
                          ), // Set width to 50% of the device width
                        ),
                      ),
                    ],
                  ),
                ),SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "Services",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28,color: Color.fromARGB(197, 0, 0, 0)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: Color(0XFF7acabc),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image(
                      image: NetworkImage(
                          "https://graphicsfamily.com/wp-content/uploads/edd/2022/01/Free-Simple-Banner-Template-scaled.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: Color(0XFF7acabc),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image(
                      image: NetworkImage(
                          "https://www.discountdisplays.co.uk/assets/images/banner-frame-top-24.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Color(0XFF7acabc),
                    ),
                    child: Image(
                      image: NetworkImage(
                          "https://images-platform.99static.com/65y8kLMsLq10KpPWdjEtyHJL7t0=/0x0:1000x1000/500x500/top/smart/99designs-contests-attachments/79/79374/attachment_79374226"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
