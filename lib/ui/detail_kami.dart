import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/kami.dart';

class DetailKami extends StatefulWidget {
  final String code;
  DetailKami({this.code});
  @override
  _DetailKamiState createState() => _DetailKamiState();
}

class _DetailKamiState extends State<DetailKami> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    return new StreamBuilder(
        stream: kamiBloc.getDataKamiByCode(widget.code),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            );
          } else {
            return new Stack(
              children: <Widget>[
                new Container(
                  color: Colors.white,
                ),
                new Container(
                  height: screen.size.height / 2.5,
                  decoration: new BoxDecoration(
                    color: Color(0xff161661),
                    borderRadius: new BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                new Positioned(
                  left: 240,
                  top: 140,
                  right: 10,
                  bottom: 320,
                  child: new Hero(
                    tag: snapshot.data.documents[0]["code"],
                    child: new Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('assets/images/person.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                new Positioned(
                  left: 20,
                  top: 80,
                  right: 120,
                  bottom: 150,
                  child: Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          snapshot.data.documents[0]["fullname"],
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        new Text(
                          '${snapshot.data.documents[0]["status"]} (${snapshot.data.documents[0]["periode"]})',
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 0,
                        ),
                        new Text(
                          '${snapshot.data.documents[0]["years_old"]} Tahun',
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 30,
                        ),
                        new Text(
                          '"${snapshot.data.documents[0]["quote"]}"',
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        });
  }
}
