import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/ui/home.dart';

class TransactionDonation extends StatefulWidget {
  @override
  _TransactionDonationState createState() => _TransactionDonationState();
}

class _TransactionDonationState extends State<TransactionDonation> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Instruki Pembayaran"),
        backgroundColor: Color(0xff161661),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: new Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: new Column(
                  children: <Widget>[
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Instruksi Pembayaran",
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Transfer sesuai nominal di bawah ini:",
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Rp. 50.000",
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        color: Color(0xfffafba4),
                        shape: BoxShape.rectangle,
                      ),
                      child: new ListTile(
                        leading: new Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        title: new Text(
                          "Penting! Mohon Transfer tepat sampai 3 angka terakhir agar donasi berjalan dengan lancar",
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: new Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: new Column(
                  children: <Widget>[
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Pembyaran dilakukan ke Rekening a/n",
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Komunias Lentera Lipuku Touna",
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                      ),
                      child: new ListTile(
                        leading: new Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        title: new Text(
                          "4102121232",
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Divider(
                      color: Colors.white,
                    ),
                    new Text(
                      "Transfer sebelum 02 Maret 2020 21:57 Wita atau donasi kamu otomatis dibatalkan oleh sistem",
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: new MaterialButton(
              color: Color(0xff161661),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: new Text(
                "Kembali Ke Halaman Utama",
                style: GoogleFonts.raleway(
                  textStyle: new TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
