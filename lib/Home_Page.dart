import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollcontroller = new ScrollController();

  List<dynamic> _anncList = new List();
  List<dynamic> tag;
  int _maxGet = 10;
  bool _visible = false;

  goDetail() {
    print(tag[1]);
    Navigator.of(context).pushReplacementNamed('/anncDetail', arguments: tag);
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
    });
  }

  Future<void> _onRefresh() async {
    print('refresh');
    _getAnnc(true);
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use refreshFailed()
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
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    final double _scrHeight = MediaQuery.of(context).size.height;
    final double _scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        //bottomOpacity: 0,
        //brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          'Announcements',
          style: GoogleFonts.montserrat(
            color: Colors.white, //Color(0xff393e46),
            fontWeight: FontWeight.w700,
            fontSize: 25,
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
                              color: Colors.redAccent,
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
                                            duration: Duration(milliseconds: 500),
                                            opacity: _visible ? 1 : 0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data[index]['Header'],
                                                  style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20,
                                                    color: Color(0xff393e46),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data[index]['subHeader'],
                                                  style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: Color(0xff393e46)
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  snapshot.data[index]['stampid'],
                                                  style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                    color: Color(0xff393e46),
                                                  ),
                                                ),
                                              ],
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
