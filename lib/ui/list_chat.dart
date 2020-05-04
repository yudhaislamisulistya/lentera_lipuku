import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_lipuku/blocs/group_chat.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart';
import 'package:lentera_lipuku/ui/animation/fade_animation.dart';
import 'package:lentera_lipuku/ui/chat.dart';

class ListChat extends StatefulWidget {
  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  double waitingTime;

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lentera Lipuku"),
        backgroundColor: Color(0xff161661),
        centerTitle: true,
      ),
      body: new Container(
        color: Color(0xff161661),
        child: new StreamBuilder(
          stream: bloc.allTodo,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Container();
            } else {
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return FadeAnimation(
                    0.3,
                    _buildContainerListDonation(
                        snapshot.data.documents[index]['name']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContainerListDonation(title) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) {
              return new Chat();
            },
          ),
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
                        "19 Orang Bergabung",
                        style: GoogleFonts.raleway(
                          textStyle: new TextStyle(
                            color: Color(0xff161661),
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
    );
  }
}

// new FadeAnimation(
//   0.5,
//   new Container(
//     margin: const EdgeInsets.symmetric(
//       horizontal: 20,
//       vertical: 5,
//     ),
//     child: new Text(
//       "Grub",
//       style: GoogleFonts.raleway(
//         textStyle: new TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//         ),
//       ),
//     ),
//   ),
// ),
