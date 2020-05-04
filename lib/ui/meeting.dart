import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/meeting.dart';
import 'package:lentera_lipuku/ui/home.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart' as googleSign;

class Meeting extends StatefulWidget {
  var data;
  Meeting({this.data});
  @override
  MeetingState createState() => MeetingState();
}

class MeetingState extends State<Meeting> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.data["title"]),
        backgroundColor: Color(0xff161661),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: null,
            builder: (context, snapshot) {
              return new ListView(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Text(
                        "Absensi Online",
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      new Text(
                        widget.data["title"],
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'date': DateTime.now(),
                      'accept_terms': false,
                    },
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderSignaturePad(
                          attribute: "signature",
                          height: MediaQuery.of(context).size.height - 300,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          "Reset",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          _fbKey.currentState.reset();
                        },
                      ),
                      new SizedBox(
                        width: 5,
                      ),
                      MaterialButton(
                        child: Text(
                          "Submit",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          pr.show();
                          Future.delayed(
                            Duration(
                              seconds: 2,
                            ),
                          ).then(
                            (onValue) {
                              if (pr.isShowing()) {
                                pr.hide();
                                if (_fbKey.currentState.saveAndValidate()) {
                                  print(_fbKey.currentState.value["signature"]);
                                  if (_fbKey.currentState.value["signature"] !=
                                      null) {
                                    var meetingPresent = {
                                      "email": googleSign.email,
                                      "code": widget.data["code"],
                                      "signature": _fbKey
                                          .currentState.value["signature"],
                                      "create_at": DateTime.now(),
                                      "updated_at": DateTime.now(),
                                    };
                                    meetingBloc.addSaveMeetingPresentByEmail(
                                        meetingPresent);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Status"),
                                          content: new Text(
                                              "Data Hasil Ditambahkan"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home(),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    print("Anda Masuk Ke Halaman Gagal");
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Status"),
                                          content: new Text("Absensi Gagal"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
