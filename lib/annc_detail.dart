import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnncDetail extends StatefulWidget {
  List<dynamic> tag;

  AnncDetail({this.tag});

  @override
  _AnncDetailState createState() => _AnncDetailState(tag: tag);
}

class _AnncDetailState extends State<AnncDetail> {
  List<dynamic> tag;

  _AnncDetailState({this.tag});

  @override
  Widget build(BuildContext context) {
    final double _scrHeight = MediaQuery.of(context).size.height;
    final double _scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: _scrWidth * 0.85,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400].withOpacity(.5),
                      blurRadius: 15,
                      spreadRadius: 10)
                ],
              ),
              child: Column(
                children: <Widget>[
                  SelectableText(
                    tag[0],
                    style: GoogleFonts.montserrat(
                        fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 5),
                  SelectableText(
                    tag[1],
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    tag[2],
                    style: GoogleFonts.lato(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    tag[3],
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      color: Colors.grey
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
