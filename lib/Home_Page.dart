import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecttiga/widgets/colorLib.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  List<dynamic> userDetail;

  HomePage({this.userDetail});

  @override
  _HomePageState createState() => _HomePageState(userDetail: userDetail);
}

class _HomePageState extends State<HomePage> {
  List<dynamic> userDetail;

  _HomePageState({this.userDetail});

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 10) {
      return 'Good Morning';
    }
    if (hour < 18) {
      return 'Good Afternoon';
    }

    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    double _scrHeight = MediaQuery.of(context).size.height;
    double _scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: libColor1,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Icon(Icons.settings, size: 25),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: Icon(Icons.supervised_user_circle),
          ),
          SizedBox(width: 30),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: _scrWidth,
                  //color: Colors.indigo[900].withOpacity(.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        greeting(),
                        style: GoogleFonts.montserrat(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[200]),
                      ),
                      Text(
                        userDetail[1],
                        style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[200]),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(10),
                  height: 120,
                  width: _scrWidth,
                  decoration: BoxDecoration(
                      color: libColor5.withOpacity(.7),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            userDetail[2],
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[200]),
                          ),
                          Text(
                            userDetail[0],
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[200]),
                          )
                        ],
                      ),
                      Spacer(),
                      QrImage(
                        data: userDetail[0],
                        version: QrVersions.auto,
                        size: 100,
                        gapless: true,
                        foregroundColor: Colors.grey[200],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(15),
                      height: 120,
                      width: _scrWidth * .55,
                      decoration: BoxDecoration(
                          color: libColor5.withOpacity(.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Tingkat II',
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[200]),
                          ),
                          Text(
                            'Rekayasa Keamanan Siber Echo',
                            softWrap: true,
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[200]),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              'No. 19',
                              style: GoogleFonts.lato(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[200]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(15),
                        height: 120,
                        //width: _scrWidth*.55,
                        decoration: BoxDecoration(
                            color: libColor5.withOpacity(.7),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'ASTRA B',
                              style: GoogleFonts.lato(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[200]),
                            ),
                            Text(
                              'B.506',
                              softWrap: true,
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey[200]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 120,
                  width: _scrWidth,
                  decoration: BoxDecoration(
                      color: libColor5.withOpacity(.7),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Container(
                        width: 150,
                        child: Center(
                          child: Text(
                            'Staff Bagian Dokumentasi dan Rumah Tangga',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[200]),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: double.infinity,
                        width: 180,
                        child: Center(
                          child: Text(
                            'Biro Umum',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[200]),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: libColor6.withOpacity(.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SlidingUpPanel(
            color: Colors.grey[200],
            defaultPanelState: PanelState.OPEN,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            maxHeight: _scrHeight * .75,
            panelBuilder: (scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 10,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(height: 23),
                    Container(
                      child: Text(
                        "What Would You Do ?",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.all(10),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        //childAspectRatio: _scrWidth/_scrHeight,
                        controller: scrollController,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: GestureDetector(
                              child: Container(
                                color: libColor4,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: -20,
                                      bottom: -30,
                                      child: Icon(
                                        Icons.record_voice_over,
                                        color: Colors.red[900].withOpacity(.2),
                                        size: 200,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Announcements',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/annc', arguments: userDetail);
                              },
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              color: libColor2,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: -50,
                                    top: 5,
                                    child: Icon(
                                      Icons.event_available,
                                      color: Colors.blue[900].withOpacity(.15),
                                      size: 200,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              color: libColor3,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: -20,
                                    bottom: -30,
                                    child: Icon(
                                      Icons.camera,
                                      color: Colors.yellow[900].withOpacity(.2),
                                      size: 200,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Camera',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              color: Colors.grey[400],
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Coming Soon',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
