import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:lentera_lipuku/blocs/donations.dart';
import 'package:lentera_lipuku/ui/detail_donation.dart';

class Donation extends StatefulWidget {
  @override
  DonationState createState() => DonationState();
}

class DonationState extends State<Donation> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Donasi'),
        backgroundColor: Color(0xff161661),
      ),
      body: new Container(
        margin: EdgeInsets.all(10),
        child: new StreamBuilder(
          stream: donationBloc.getDataListDonation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Container(
                child: new Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data.documents[index];
                  return _buildContainerListDontaion(data);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContainerListDontaion(data) {
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
                  tag: 'imageDonation',
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailDonation(
                            data: data,
                          ),
                        ),
                      );
                    },
                    child: new Container(
                      height: 90,
                      width: 150,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('assets/images/gambar1.jpg'),
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
                      RoundedProgressBar(
                        height: 10,
                        style: RoundedProgressBarStyle(
                          borderWidth: 0,
                          widthShadow: 0,
                          colorProgress: Color(0xff161661),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        borderRadius: BorderRadius.circular(24),
                        percent:
                            (data["start_donation"] / data["end_donation"]) *
                                100,
                      ),
                      new Text(
                        'Terkumpul',
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      new Text(
                        'Rp. 15.000.000,00',
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
