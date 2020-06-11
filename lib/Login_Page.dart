import 'dart:convert';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  AnimationController controller;
  AnimationController controller1;
  Animation<double> animation;
  Animation<double> animation1;

  bool _ErrorUser = false;
  bool _ErrorPass = false;
  bool _showPass = false;
  bool _keepLog = false;
  String nama = "";
  String msg = "";
  double _animateWidth = 200;
  double _animateHeight = 50;

  Future<List> _login() async {
    final response = await http.post(
        "http://192.168.43.79/ProjectTiga/login.php",
        body: {"username": _username.text});
    print(response.body);
    var _datauser = json.decode(response.body);
    if (_datauser.length == 0) {
      setState(() {
        msg = "Incorrect Username";
        _ErrorPass = true;
        _ErrorUser = true;
      });
    } else if (_datauser[0]['password'] == _password.text) {
      setState(() {
        _ErrorPass = false;
        _ErrorUser = false;
        msg = "";
        nama = _datauser[0]['nama_panggilan'];
        controller.forward();
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        controller1.forward();
      });
      Future.delayed(Duration(milliseconds: 5000), () {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    } else {
      _ErrorPass = true;
      _ErrorUser = false;
      msg = "Incorrect Password";
      print('pass salah');
    }
  }


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCirc,
    );
    animation1 = CurvedAnimation(
      parent: controller1,
      curve: Curves.easeInOutCirc,
    );
  }

//  @override
//  void dispose() {
//    controller.dispose();
//    controller1.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {

    Color _color = Color(0xFFf2f2f2); // Colors.grey[200]
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      //statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: _color,
    ));

    double _scrWidth = MediaQuery.of(context).size.width;
    double _scrHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Container(
                        child: Image.asset(
                      'images/secretowlgrey.png',
                      width: _scrWidth * 0.6,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 95, top: 70),
                      child: Icon(
                        Icons.copyright,
                        color: Color(0xff393e46),
                        size: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    width: _scrWidth * 0.85,
                    height: _scrHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(.5),
                            blurRadius: 15,
                            spreadRadius: 5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            child: TextFormField(
                              controller: _username,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(color: Colors.grey[900]),
                              decoration: InputDecoration(
                                labelText: ' Username',
                                labelStyle:
                                    GoogleFonts.lato(color: Color(0xff393e46)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                        color: _ErrorUser
                                            ? Colors.red
                                            : Colors.transparent,
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Color(0xff32e0c4), width: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              Container(
                                //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                child: TextFormField(
                                  obscureText: _showPass ? false : true,
                                  textAlign: TextAlign.center,
                                  style:
                                      GoogleFonts.lato(color: Colors.grey[900]),
                                  controller: _password,
                                  decoration: InputDecoration(
                                    labelText: ' Password',
                                    labelStyle: GoogleFonts.lato(
                                        color: Color(0xff393e46)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: _ErrorPass
                                              ? Colors.red
                                              : Colors.transparent,
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0xff32e0c4),
                                            width: 2)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPass = !_showPass;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 22),
                                  child: AnimatedCrossFade(
                                    duration: Duration(milliseconds: 200),
                                    firstChild: Icon(
                                      Icons.visibility,
                                      color: Color(0xff32e0c4),
                                      size: 28,
                                    ),
                                    secondChild: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey.withOpacity(0.5),
                                      size: 28,
                                    ),
                                    crossFadeState: _showPass
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff32e0c4),
                            dense: true,
                            title: Text(
                              "Keep me signed in",
                              style: GoogleFonts.lato(color: Colors.grey),
                            ),
                            value: _keepLog,
                            onChanged: (bool newValue) async {
                              setState(() {

                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .trailing, //  <-- leading Checkbox
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: MaterialButton(
                    animationDuration: Duration(seconds: 1),
                    color: Color(0xff32e0c4),
                    splashColor: Colors.white.withOpacity(.5),
                    onPressed: () {
                      setState(() {
                        _animateWidth -= 20;
                        _animateHeight -= 10;
                      });
                      Future.delayed(Duration(milliseconds: 150), () {
                        setState(() {
                          _animateWidth += 40;
                          _animateHeight += 20;
                        });
                      });
                      Future.delayed(Duration(milliseconds: 400), () {
                        setState(() {
                          _animateWidth -= 20;
                          _animateHeight -= 10;
                        });
                      });
                      _login();
                      print('login pressed');
                      //print(_Error);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: _animateWidth,
                      height: _animateHeight,
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(msg, style: GoogleFonts.lato(color: Colors.red)),
              ],
            ),
            Center(
              child: CircularRevealAnimation(
                animation: animation,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xff32e0c4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color: Colors.white),
                      ),
                      FadeTransition(
                        opacity: animation1,
                        child: Text(
                          nama,
                          style: GoogleFonts.montserrat(
                              fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
