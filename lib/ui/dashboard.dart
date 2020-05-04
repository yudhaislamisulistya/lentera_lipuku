import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/kami.dart';
import 'package:lentera_lipuku/blocs/tips.dart';
import 'package:lentera_lipuku/ui/animation/fade_animation.dart';
import 'package:lentera_lipuku/ui/detail_kami.dart';
import 'package:lentera_lipuku/ui/detail_tip.dart';
import 'package:lentera_lipuku/ui/donation.dart';
import 'package:lentera_lipuku/ui/kami.dart';
import 'package:lentera_lipuku/ui/list_event.dart';
import 'package:lentera_lipuku/ui/list_tip.dart';
import 'package:lentera_lipuku/ui/maps.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart' as googleSign;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lentera Lipuku'),
        backgroundColor: Color(0xff161661),
        centerTitle: true,
      ),
      body: new Container(
        color: Color(0xff161661),
        child: new ListView(
          children: <Widget>[
            new SizedBox(
              height: 20,
            ),
            new FadeAnimation(
              1.0,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: new Container(
                  padding: const EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  googleSign.name,
                                  style: GoogleFonts.raleway(
                                    textStyle: new TextStyle(
                                      color: Color(0xff161661),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                new Text(
                                  "Partisipan",
                                  style: GoogleFonts.raleway(
                                    textStyle: new TextStyle(
                                      color: Color(0xff161661),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            new Container(
                              width: 40,
                              height: 40,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new NetworkImage(googleSign.imageUrl),
                                ),
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new SizedBox(
              height: 20,
            ),
            new FadeAnimation(
              1.2,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildMenuDashboard(Icons.attach_money, 'Donasi'),
                    _buildMenuDashboard(Icons.people, 'Kami'),
                    _buildMenuDashboard(Icons.event_note, 'Event'),
                    _buildMenuDashboard(Icons.map, 'Lokasi'),
                  ],
                ),
              ),
            ),
            new SizedBox(
              height: 25,
            ),
            new FadeAnimation(
              1.4,
              new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          'Tip',
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return new ListTip();
                                },
                              ),
                            );
                          },
                          child: new Text(
                            'Lihat Selengkapnya',
                            style: GoogleFonts.raleway(
                              textStyle: new TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: new Divider(
                      color: Colors.white,
                    ),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Container(
                    width: double.infinity,
                    height: 100,
                    child: new StreamBuilder(
                      stream: tipsBloc.getDataTipsByLimitThree(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Container(
                            child: new Center(
                              child: new CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data.documents[index];
                              return new Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: new Hero(
                                  tag: data["code"],
                                  child: new GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailTip(
                                            code: data["code"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: _buildContainerTip(
                                      data["title"],
                                      data["file_image"],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            new SizedBox(
              height: 25,
            ),
            new FadeAnimation(
              1.6,
              new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          'Pengurus',
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return new Kami();
                                },
                              ),
                            );
                          },
                          child: new Text(
                            'Lihat Selengkapnya',
                            style: GoogleFonts.raleway(
                              textStyle: new TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: new Divider(
                      color: Colors.white,
                    ),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Container(
                    width: double.infinity,
                    height: 180,
                    child: new StreamBuilder(
                      stream: kamiBloc.getDataKamiByLimitThree(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Container(
                            child: new Center(
                              child: new CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data.documents[index];
                              return new Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: new Hero(
                                  tag: data["code"],
                                  child: new GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailKami(
                                            code: data["code"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: _buildContainerPengurus(
                                        data["fullname"],
                                        "assets/images/person.png",
                                        data["divition"]),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainerPengurus(name, image, title) {
    return new Container(
      width: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [
            0.0,
            0.0,
          ],
          colors: [Colors.white, Color(0xff010a43)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            offset: new Offset(0, 8),
            blurRadius: 8,
          )
        ],
      ),
      child: new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: new RotatedBox(
              quarterTurns: 1,
              child: new Text(
                title,
                style: GoogleFonts.raleway(
                  textStyle: new TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
          new Positioned(
            left: 17,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: new RotatedBox(
                quarterTurns: 1,
                child: new Text(
                  name,
                  style: GoogleFonts.raleway(
                    textStyle: new TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, top: 10, bottom: 10),
            child: new Container(
              height: 400,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(
                    image,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainerTip(title, image) {
    return new Container(
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff010a43).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  title,
                  style: GoogleFonts.raleway(
                    textStyle: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuDashboard(icon, title) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new InkWell(
            onTap: () {
              if (title == "Donasi") {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return new Donation();
                    },
                  ),
                );
              } else if (title == "Kami") {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return new Kami();
                    },
                  ),
                );
              } else if (title == "Event") {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return new ListEvent();
                    },
                  ),
                );
              } else if (title == "Lokasi") {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return new Maps();
                    },
                  ),
                );
              }
            },
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: new Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
              padding: EdgeInsets.all(12),
            ),
          ),
          new SizedBox(
            height: 5,
          ),
          new Text(
            title,
            style: GoogleFonts.raleway(
              textStyle: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
