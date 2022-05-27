import 'package:bakoelku/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildMaps(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 90),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: meGreen),
                        color: Colors.white
                      ),
                      child: Icon(
                        Icons.settings,
                        color: meGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: meGreen),
                        color: Colors.white
                      ),
                      child: Text(
                        "Cari Pedagang Kesukaanmu...",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 90),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: meGreen),
                        color: Colors.white
                      ),
                      child: Icon(
                        Icons.search,
                        color: meGreen,
                      ),
                    ),
                  ),
                ],
              ),

              // for Detail menu
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/mart-dummy.png",
                        height: 75,
                      ),

                       ListTile(
                        title: const Text(
                          "Mie Ayam Solo",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: const Text(
                          "Kota Surabaya",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: meGreen,
                              radius: 16,
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              backgroundColor: meGreen,
                              radius: 16,
                              child: const Icon(
                                Icons.messenger,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Button for next

                      const SizedBox(height: 13,),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: meGreen,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Menuju Lokasi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.white,
                              size: 28,
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ]
      ),
    );
  }
}

Widget buildMaps() {
  return GestureDetector(
    child: Column(
      children: <Widget>[
        Expanded(
          child: Image.asset(
            'assets/images/maps_screenshot.png',
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ))
      ],
    ),
  );
}