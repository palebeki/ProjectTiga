import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colorLib.dart';

class MyDrawer extends StatefulWidget {
  List<dynamic> userDetail;
  MyDrawer({this.userDetail});
  @override
  _MyDrawerState createState() => _MyDrawerState(userDetail: userDetail);
}

class _MyDrawerState extends State<MyDrawer> {

  List<dynamic> userDetail;
  _MyDrawerState({this.userDetail});

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
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100,),
            Text(
              greeting(),
              style: GoogleFonts.montserrat(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                height: .85,
                color: Color(0xff393e46),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              userDetail[1],
              style: GoogleFonts.lato(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff393e46)),
            ),
            //Text(userDetail[2]),
            Text(
              userDetail[0],
              style: GoogleFonts.lato(color: Colors.black54),
            ),
            SizedBox(height: 20),
            Divider(
              color: libColor1,
            ),
            SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.announcement, size: 30,color:  Color(0xff393e46).withOpacity(.5),),
                SizedBox(width: 10,),
                Text('Announcements', style: GoogleFonts.lato(fontSize: 16,color: Color(0xff393e46).withOpacity(.5))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.event_available, size: 30,color:  Color(0xff393e46),),
                SizedBox(width: 10,),
                Text('Register', style: GoogleFonts.lato(fontSize: 16,color: Color(0xff393e46))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.camera, size: 30,color:  Color(0xff393e46),),
                SizedBox(width: 10,),
                Text('Scan', style: GoogleFonts.lato(fontSize: 16,color: Color(0xff393e46))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.info, size: 30,color:  Color(0xff393e46),),
                SizedBox(width: 10,),
                Text('About', style: GoogleFonts.lato(fontSize: 16,color: Color(0xff393e46))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.settings, size: 30,color:  Color(0xff393e46),),
                SizedBox(width: 10,),
                Text('Settings', style: GoogleFonts.lato(fontSize: 16,color: Color(0xff393e46))),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: libColor1,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'LOGOUT',
                      style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15, letterSpacing: 2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
