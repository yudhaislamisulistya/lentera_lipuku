import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/meeting.dart';
import 'package:lentera_lipuku/ui/meeting.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ListMeeting extends StatefulWidget {
  @override
  ListMeetingState createState() => ListMeetingState();
}

class ListMeetingState extends State<ListMeeting> {
  TextEditingController controllerCodeMeeting = new TextEditingController();
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Lentera Lipuku'),
        backgroundColor: Color(0xff161661),
        centerTitle: true,
      ),
      body: new Container(
        color: Color(0xff161661),
        child: new StreamBuilder(
          stream: meetingBloc.getDataMeeting(),
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
                  var data = snapshot.data.documents[index];
                  return _buildContainerListDonation(
                    data["title"],
                    "${data["date"]} (${data["start_time"]} - ${data["end_time"]})",
                    data["code"],
                    data,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContainerListDonation(title, datetime, code, data) {
    return new InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(
                    "Kode Rapat",
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: new TextField(
                    controller: controllerCodeMeeting,
                  ),
                  actions: <Widget>[
                    new OutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text(
                        'Tutup',
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hoverColor: Color(0xff161661),
                      borderSide: new BorderSide(color: Color(0xff161661)),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    new FlatButton(
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
                              if (code == controllerCodeMeeting.text) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Meeting(
                                      data: data,
                                    ),
                                  ),
                                );
                              } else {}
                            }
                          },
                        );
                      },
                      child: new Text(
                        'Masuk',
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: Color(0xff161661),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: new Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        padding: const EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: new Container(
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
                          image: new AssetImage('assets/images/calendar.png'),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 10,
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          title,
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Color(0xff161661),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        new Text(
                          datetime,
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
        ),
      ),
    );
  }
}
