import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/donations.dart';

class ListDonation extends StatefulWidget {
  @override
  ListDonationState createState() => ListDonationState();
}

class ListDonationState extends State<ListDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Lentera Lipuku'),
        backgroundColor: Color(0xff161661),
        centerTitle: true,
      ),
      body: new Container(
        color: Color(0xff161661),
        child: new StreamBuilder(
          stream: donationBloc.getDataDonation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Container(
                  child: new Center(
                child: new CircularProgressIndicator(),
              ));
            } else {
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data.documents[index];
                  return _buildContainerListDonation(data["fullname"],
                      data["amount"].toString(), data["name_donation"]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContainerListDonation(name, nominal, status) {
    return new Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: 40,
                  height: 40,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/images/user.png'),
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
                      name,
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          color: Color(0xff161661),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "Berdonasi Sebesar",
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Color(0xff161661),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 3,
                        ),
                        new Text(
                          nominal,
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Color(0xff161661),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Text(
                      status,
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          color: Color(0xff161661),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
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
    );
  }
}
