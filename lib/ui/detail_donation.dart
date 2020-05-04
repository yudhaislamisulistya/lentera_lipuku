import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/donations.dart';
import 'package:lentera_lipuku/ui/transacrtion_donation.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DetailDonation extends StatefulWidget {
  final dynamic data;
  DetailDonation({this.data});
  @override
  DetailDonationState createState() => DetailDonationState();
}

class DetailDonationState extends State<DetailDonation> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController controllerNominal = new TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProgressDialog pr;

  VoidCallback _showPersBottomSheetCallBack;
  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            height: 300,
            color: Colors.greenAccent,
            child: new Center(
              child: new Text('Hi Modal Baru'),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  void _showModalSheet() {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(message: 'Showing some progress...');

    pr.style(
      message: 'Proses Order',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 420,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new SizedBox(
                  height: 10,
                ),
                new Container(
                  width: 40,
                  height: 10,
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  "Masukkan Nominal Donasi",
                  style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
                ),
                new SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'date': DateTime.now(),
                          'accept_terms': false,
                        },
                        autovalidate: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                attribute: "nominal",
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  fillColor: Colors.grey[300],
                                  focusColor: Color(0xff161661),
                                ),
                                validators: [
                                  FormBuilderValidators.numeric(),
                                ],
                                keyboardType: TextInputType.number,
                              ),
                              FormBuilderDropdown(
                                attribute: "gender",
                                decoration: InputDecoration(
                                    labelText: "Metode Pembayaran"),
                                initialValue: 'BRI',
                                items: [
                                  'BRI',
                                  'MANDIRI',
                                  'BCA',
                                  "BNI",
                                  "Lainnya"
                                ]
                                    .map((gender) => DropdownMenuItem(
                                        value: gender, child: Text("$gender")))
                                    .toList(),
                              ),
                              FormBuilderCheckbox(
                                attribute: 'anonim',
                                label: Text("Sembunyikan Nama Saya (Anonim)"),
                                onChanged: (val) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new FlatButton(
                  color: Color(0xff161661),
                  onPressed: () {
                    // set up the buttons
                    Widget cancelButton = FlatButton(
                      child: Text(
                        "Tidak",
                        style: new TextStyle(
                          color: Color(0xff161661),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                    Widget continueButton = FlatButton(
                      child: Text(
                        "Ya",
                        style: new TextStyle(
                          color: Color(0xff161661),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        pr.show();
                        Future.delayed(
                          Duration(
                            seconds: 2,
                          ),
                        ).then(
                          (onValue) {
                            if (pr.isShowing()) {
                              pr.hide();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionDonation(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }
                          },
                        );
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      content: Text("Apakah Benar Mau Melakukan Donasi?"),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: new Text(
                    "Donasi",
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  nasted() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxScroller) {
        return <Widget>[
          SliverAppBar(
            title: new Text(
              'Donasi Bersama Kami',
              style: GoogleFonts.raleway(
                textStyle: new TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            expandedHeight: 170,
            floating: false,
            backgroundColor: Color(0xff161661),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.share), onPressed: () {})
            ],
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              centerTitle: true,
              background: new Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                color: Colors.white,
                child: new Hero(
                  tag: 'imageDonation',
                  child: new Container(
                    height: 90,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/images/gambar1.jpg'),
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
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            new Text(
              widget.data["title"],
              style: GoogleFonts.raleway(
                textStyle: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    widget.data["start_donation"].toString(),
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        color: Color(0xff161661),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  new Text(
                    'Terkumpul dari ${widget.data["end_donation"]}',
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        color: Color(0xff161661),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
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
              percent: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    '10',
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        color: Color(0xff161661),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  new Text(
                    'Donasi',
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        color: Color(0xff161661),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new MaterialButton(
              onPressed: () {
                _showModalSheet();
              },
              color: Color(0xfff9b316),
              child: new Text(
                'Donasi',
                style: GoogleFonts.raleway(
                  textStyle: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
                        'Cerita',
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      new Text(
                        widget.data["create_at"],
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
                  new Text(
                    widget.data["story"],
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            new SizedBox(
              height: 10,
            ),
            new Row(
              children: <Widget>[
                new Text(
                  'Donasi (10)',
                  style: GoogleFonts.raleway(
                    textStyle: new TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            new Divider(),
            new StreamBuilder(
              stream: donationBloc
                  .getDataListDonationByCodeDonation(widget.data["code"]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Container(
                    child: new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return new Expanded(
                    child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return _buildContainerListDonation();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerListDonation() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.2),
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
                      image: new AssetImage('assets/images/yudha.jpeg'),
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
                      'Yudha Islami Sulistya',
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
                          "Rp. 15.000",
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
                      'Donasi Umum',
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: nasted(),
    );
  }
}
