import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/events.dart';
import 'package:lentera_lipuku/ui/animation/fade_animation.dart';

class ListEvent extends StatefulWidget {
  @override
  ListEventState createState() => ListEventState();
}

class ListEventState extends State<ListEvent> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Event'),
        backgroundColor: Color(0xff161661),
      ),
      body: new Container(
        margin: EdgeInsets.all(10),
        child: new StreamBuilder(
          stream: blocEvent.allEvents,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Container();
            } else {
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  dynamic data = snapshot.data.documents[index];
                  return FadeAnimation(0.3, _buildContainerEvent(data));
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContainerEvent(data) {
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
                new Container(
                  height: 90,
                  width: 150,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(data["file_image"]),
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
                        '22 Februari 2020',
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
  }
}
