import 'dart:convert';
import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:projecttiga/widgets/colorLib.dart';

class HomePage extends StatefulWidget {
  List<dynamic> userDetail;

  HomePage({this.userDetail});

  @override
  _HomePageState createState() => _HomePageState(userDetail: userDetail);
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollcontroller = new ScrollController();

  List<dynamic> userDetail;

  _HomePageState({this.userDetail});

  List<dynamic> tag;
  int _maxGet = 10;
  bool _visible = false;

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

  goDetail() {
    print(tag[1]);
    //Navigator.of(context).pushReplacementNamed('/anncDetail', arguments: tag);
    Navigator.of(context).pushNamed('/anncDetail', arguments: tag);
    //Navigator.of(context).popAndPushNamed('/anncDetail', arguments: tag);
  }

  Future<List> _getAnnc(bool stat) async {
    final response = await http.post(
        "http://192.168.43.79/ProjectTiga/getAnncData.php",
        body: {"maxGet": _maxGet.toString()});

    if (stat == null || stat == true) {
      setState(() {
        response.body;
      });

    }

    return json.decode(response.body);
  }

  _getMore() {
    setState(() {
      _maxGet = _maxGet + 10;
      _getAnnc(true);
      print('get More $_maxGet');
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        animationDuration: Duration(milliseconds: 500),
        barBlur: 1.0,
        message:  "Loaded More Announcements",
        duration:  Duration(seconds: 3),
      )..show(context);
    });
  }

  Future<void> _onRefresh() async {
    print('refresh');
    _getAnnc(true);
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use refreshFailed()
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      icon: Icon(
        Icons.refresh,
        size: 28.0,
        color: Colors.blue[300],
      ),
      animationDuration: Duration(milliseconds: 500),
      barBlur: 1.0,
      message:  "Announcements Refreshed",
      duration:  Duration(seconds: 3),
    )..show(context);
  }

  @override
  void initState() {
    print('homePage');
    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.pixels ==
          _scrollcontroller.position.maxScrollExtent) {
        _getMore();
        print(_scrollcontroller.position.pixels);
        //AnimatedList.of(context).insertItem(index)
      }
    });
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      //statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    final double _scrHeight = MediaQuery.of(context).size.height;
    final double _scrWidth = MediaQuery.of(context).size.width;
    double _sizeBar = MediaQuery.of(context).size.width * 0.65;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        //bottomOpacity: 0,
        //brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: libBlue,
        title: Text(
          'Announcements',
          style: GoogleFonts.montserrat(
            color: Colors.white, //Color(0xff393e46),
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                    color: libBlue,
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
                          color: libBlue,
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
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: FutureBuilder(
                    future: _getAnnc(false),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? LiquidPullToRefresh(
                              height: 100,
                              color: libBlue,
                              showChildOpacityTransition: false,
                              animSpeedFactor: 5,
                              springAnimationDurationInMilliseconds: 500,
                              onRefresh: _onRefresh,
                              child: new ListView.builder(
                                  controller: _scrollcontroller,
                                  itemCount: snapshot.data.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tag = [
                                            snapshot.data[index]["Header"],
                                            snapshot.data[index]["subHeader"],
                                            snapshot.data[index]["annc"],
                                            snapshot.data[index]["stampid"]
                                          ];
                                        });
                                        goDetail();
                                      },
                                      child: Hero(
                                        tag: snapshot.data[index]['stampid'],
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 11, horizontal: 30),
                                            padding: EdgeInsets.all(10),
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[400]
                                                        .withOpacity(.5),
                                                    blurRadius: 5,
                                                    spreadRadius: 2)
                                              ],
                                            ),
                                            child: AnimatedOpacity(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              opacity: _visible ? 1 : 0,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        ['Header'],
                                                    style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 20,
                                                      color: Color(0xff393e46),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data[index]
                                                        ['subHeader'],
                                                    style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      color: Color(0xff393e46)
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    snapshot.data[index]
                                                        ['stampid'],
                                                    style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10,
                                                      color: Color(0xff393e46),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : new Center(child: new CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
