import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/tips.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class DetailTip extends StatefulWidget {
  final String code;
  DetailTip({this.code});
  @override
  DetailTipState createState() => DetailTipState();
}

class DetailTipState extends State<DetailTip> {
  nasted() {
    return StreamBuilder(
        stream: tipsBloc.getDataTipsByCode(widget.code),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Container(
                child: new Center(child: new CircularProgressIndicator()));
          } else {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxScroller) {
                return <Widget>[
                  SliverAppBar(
                    title: new Text(
                      'Tip',
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    expandedHeight: 170,
                    floating: false,
                    backgroundColor: Color(0xff161661),
                    actions: <Widget>[
                      new IconButton(
                          icon: new Icon(Icons.share), onPressed: () {})
                    ],
                    pinned: true,
                    flexibleSpace: new FlexibleSpaceBar(
                      centerTitle: true,
                      background: new Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        color: Colors.white,
                        child: new Hero(
                          tag: widget.code,
                          child: new Container(
                            height: 90,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    snapshot.data.documents[0]['file_image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: new Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: new ListView(
                  children: <Widget>[
                    new Text(
                      snapshot.data.documents[0]["title"],
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new Container(
                      padding: const EdgeInsets.all(10),
                      decoration: new BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(
                                snapshot.data.documents[0]["create_at"],
                                style: GoogleFonts.raleway(
                                  textStyle: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Html(
                            data: snapshot.data.documents[0]["content"],
                            linkStyle: const TextStyle(
                              color: Colors.redAccent,
                              decorationColor: Colors.redAccent,
                              decoration: TextDecoration.underline,
                            ),
                            onLinkTap: (url) {
                              print("Opening $url...");
                            },
                            onImageTap: (src) {
                              print(src);
                            },
                            customRender: (node, children) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "custom_tag":
                                    return Column(children: children);
                                }
                              }
                              return null;
                            },
                            customTextAlign: (dom.Node node) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "p":
                                    return TextAlign.justify;
                                }
                              }
                              return null;
                            },
                            customTextStyle:
                                (dom.Node node, TextStyle baseStyle) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "p":
                                    return baseStyle.merge(
                                      TextStyle(
                                        height: 2,
                                        fontSize: 20,
                                      ),
                                    );
                                }
                              }
                              return baseStyle;
                            },
                          ),
                        ],
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: nasted(),
    );
  }
}
