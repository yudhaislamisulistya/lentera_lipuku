import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart';
import 'package:lentera_lipuku/ui/animation/fade_animation.dart';
import 'package:lentera_lipuku/ui/home.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(message: 'Showing some progress...');

    //Optional
    pr.style(
      message: 'Silahkan Tunggu',
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
    MediaQueryData query = MediaQuery.of(context);

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        children: <Widget>[
          new Container(
            width: query.size.width,
            height: query.size.height,
            color: Color(0xff161661),
          ),
          new FadeAnimation(
            1.0,
            new Container(
              width: query.size.width,
              height: query.size.height,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage('assets/images/bglogin.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                FadeAnimation(
                  1.3,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new FadeAnimation(
                  1.6,
                  new Text(
                    '"Berbagi Bersama Kami Dari Hati Untuk Pedalaman Touna"',
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                new FadeAnimation(
                  1.9,
                  new Text(
                    'Login',
                    style: GoogleFonts.raleway(
                      textStyle: new TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new FadeAnimation(
                  2.2,
                  new Container(
                    padding: const EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.white,
                          blurRadius: 20,
                          offset: new Offset(0, 5),
                        )
                      ],
                    ),
                    child: new Column(
                      children: <Widget>[
                        _buildInputData('Email'),
                        _buildInputData('Password'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new FadeAnimation(
                  2.5,
                  Center(
                    child: new Text(
                      'Lupa Password Anda ?',
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                new FadeAnimation(
                  2.8,
                  new Center(
                    child: new SizedBox(
                      width: 300,
                      child: new FlatButton(
                        onPressed: () {},
                        color: Color(0xfff9b316),
                        child: new Text(
                          'Masuk',
                          style: GoogleFonts.raleway(
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new FadeAnimation(
                  3.1,
                  Center(
                    child: new Text(
                      'Atau',
                      style: GoogleFonts.raleway(
                        textStyle: new TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new FadeAnimation(
                  3.4,
                  new Center(
                    child: new SizedBox(
                      width: 300,
                      child: new OutlineButton(
                        onPressed: () {
                          signInWithGoogle().whenComplete(() {
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
                                      builder: (context) => Home(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              },
                            );
                          });
                        },
                        borderSide: new BorderSide(color: Color(0xfff9b316)),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'Masuk Dengan Akun Google',
                              style: GoogleFonts.raleway(
                                textStyle: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            new Container(
                              width: 20,
                              height: 20,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: AssetImage('assets/images/google.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputData(hintText) {
    return new Container(
      height: 40,
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Colors.grey[100],
          ),
        ),
      ),
      child: new TextField(
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.raleway(
            textStyle: new TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
