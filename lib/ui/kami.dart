import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/kami.dart';
import 'package:lentera_lipuku/ui/detail_kami.dart';

class Kami extends StatefulWidget {
  @override
  _KamiState createState() => _KamiState();
}

class _KamiState extends State<Kami> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Inti'),
    Tab(text: 'Kesekretariatan'),
    Tab(text: 'Keorganisasian'),
    Tab(text: 'Pelatihan Dan Pendidikan'),
    Tab(text: 'Kerohanian'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Kami'),
        backgroundColor: Color(0xff161661),
        bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListKami(
            divition: "Inti",
            status: "Aktif",
          ),
          ListKami(
            divition: "Kesekretariatan",
            status: "Aktif",
          ),
          ListKami(
            divition: "Keorganisasian",
            status: "Aktif",
          ),
          ListKami(
            divition: "Pelatihan Dan Pendidikan",
            status: "Aktif",
          ),
          ListKami(
            divition: "Kerohanian",
            status: "Aktif",
          ),
        ],
      ),
    );
  }
}

class ListKami extends StatefulWidget {
  final String divition, status;
  ListKami({this.divition, this.status});
  @override
  _ListKamiState createState() => _ListKamiState();
}

class _ListKamiState extends State<ListKami> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: kamiBloc.getDataKamiByDivitionAndStatus(
          widget.divition, widget.status),
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
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: new Hero(
                  tag: data["code"],
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return new DetailKami(
                          code: data["code"],
                        );
                      }));
                    },
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                width: 40,
                                height: 40,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/images/person.png'),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    data["fullname"],
                                    style: GoogleFonts.raleway(
                                      textStyle: new TextStyle(
                                          color: Color(0xff161661),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                  new Text(
                                    '${data["status"]} (${data["periode"]})',
                                    style: GoogleFonts.raleway(
                                      textStyle: new TextStyle(
                                        color: Color(0xff161661),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
