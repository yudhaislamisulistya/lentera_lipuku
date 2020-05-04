import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart';
import 'package:lentera_lipuku/ui/animation/fade_animation.dart';
import 'package:lentera_lipuku/ui/login.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart' as googleSign;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Lentera Lipuku"),
        backgroundColor: Color(0xff161661),
      ),
      body: Container(
        color: Color(0xff161661),
        child: new ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    color: Color(0xff161661),
                    width: media.width,
                    height: media.height / 3,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new FadeAnimation(
                          0.5,
                          new Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(googleSign.imageUrl),
                              ),
                            ),
                          ),
                        ),
                        new FadeAnimation(
                          0.8,
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: new Text(
                              googleSign.name,
                              style: GoogleFonts.raleway(
                                textStyle: new TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        new FadeAnimation(
                          1.1,
                          new Text(
                            googleSign.email,
                            style: GoogleFonts.raleway(
                              textStyle: new TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new FadeAnimation(
                  1.4,
                  new Card(
                    margin: EdgeInsets.only(
                        top: media.height / 3.5, left: 20, right: 20),
                    child: new Container(
                      height: media.height / 10,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  "Donasi",
                                  style: GoogleFonts.raleway(
                                    textStyle: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                new Text(
                                  "1000",
                                  style: GoogleFonts.raleway(
                                    textStyle: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: new Container(
                    margin: EdgeInsets.only(
                        top: media.height / 2.5,
                        left: 20,
                        right: 20,
                        bottom: 20),
                    child: new Column(
                      children: <Widget>[
                        new FadeAnimation(1.7,
                            buildContainerOther(media, "Syarat Dan Ketentuan")),
                        new SizedBox(
                          height: 3,
                        ),
                        new FadeAnimation(2.0,
                            buildContainerOther(media, "Kebijakan Pengguna")),
                        new SizedBox(
                          height: 3,
                        ),
                        new FadeAnimation(
                            2.3, buildContainerOther(media, "F A Q")),
                        new SizedBox(
                          height: 3,
                        ),
                        new FadeAnimation(
                          2.6,
                          buildContainerOther(media,
                              "Berikan Penilaian Aplikasi Lentera Lipuku"),
                        ),
                        new SizedBox(
                          height: 3,
                        ),
                        new InkWell(
                          onTap: () {
                            signOutGoogle();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: new FadeAnimation(
                              2.9, buildContainerOther(media, "Keluar")),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerOther(Size media, String title) {
    return new Container(
      width: media.width / 1.1,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Text(
          title,
          style: GoogleFonts.raleway(
            textStyle: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
