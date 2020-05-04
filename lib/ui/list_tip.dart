import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/tips.dart';
import 'package:lentera_lipuku/ui/detail_tip.dart';

class ListTip extends StatefulWidget {
  @override
  ListTipState createState() => ListTipState();
}

class ListTipState extends State<ListTip> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tip'),
        backgroundColor: Color(0xff161661),
      ),
      body: new Container(
        margin: EdgeInsets.all(10),
        child: new StreamBuilder(
          stream: tipsBloc.getDataTips(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Container(
                child: new Center(
                  child: new CircularProgressIndicator(),
                ),
              );
            } else {
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  dynamic data = snapshot.data.documents[index];
                  return new Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Hero(
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
                                  child: new Container(
                                    height: 90,
                                    width: 150,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: new NetworkImage(
                                            data['file_image']),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: new BorderRadius.only(
                                        bottomLeft: new Radius.circular(10),
                                        topLeft: new Radius.circular(10),
                                        bottomRight: new Radius.circular(10),
                                        topRight: new Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Expanded(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      data["title"],
                                      style: GoogleFonts.raleway(
                                        textStyle: new TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    new SizedBox(
                                      height: 5,
                                    ),
                                    new Text(
                                      data["create_at"],
                                      style: GoogleFonts.raleway(
                                        textStyle: new TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
