import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lentera_lipuku/blocs/chat.dart';
import 'package:lentera_lipuku/firebase/sign_in.dart';
import 'package:date_format/date_format.dart';
import 'package:lentera_lipuku/ui/animation/fade_animation.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController controllerContent = new TextEditingController();
  _buildMessage(data, isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Color(0xff161661) : Color(0xff010a43),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data['create_at'].toDate().toString(),
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            data['content'],
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          _buildNameMessage(data, isMe),
        ],
      ),
    );
    if (isMe) {
      return new InkWell(
        onLongPress: () {},
        child: new FadeAnimation(0.2, msg),
      );
    }
    return new FadeAnimation(
      0.2,
      Row(
        children: <Widget>[
          msg,
        ],
      ),
    );
  }

  _buildNameMessage(data, isMe) {
    if (isMe == false) {
      return new Text(
        data['name'],
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(0),
      );
    }
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controllerContent,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              style: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Color(0xff161661),
            onPressed: () {
              dynamic chatData = {
                "group_code": "12345",
                "name": name,
                "content": controllerContent.text,
                "email": email,
                "create_at": DateTime.now(),
              };
              blocChat.addSaveTodo(chatData);

              controllerContent.text = "";
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff161661),
        title: Text(
          "Grub Panitia",
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: new StreamBuilder(
                      stream: blocChat.allTodo,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Container();
                        } else {
                          return new ListView.builder(
                            padding: EdgeInsets.only(top: 15.0),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              dynamic data = snapshot.data.documents[index];
                              bool isMe = data['email'] == email;
                              return _buildMessage(data, isMe);
                            },
                          );
                        }
                      }),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
