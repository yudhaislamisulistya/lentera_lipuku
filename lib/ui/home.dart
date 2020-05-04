import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lentera_lipuku/ui/account.dart';
import 'package:lentera_lipuku/ui/dashboard.dart';
import 'package:lentera_lipuku/ui/list_chat.dart';
import 'package:lentera_lipuku/ui/list_meeting.dart';
import 'package:lentera_lipuku/ui/list_donation.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  PermissionStatus _permissionStatus;

  @override
  void initState() {
    // TODO: implement initState
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage)
        .then(_updateStatus);

    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequest);
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _permissionStatus) {
      setState(() {
        _permissionStatus = status;
      });
    }
  }

  void _onStatusRequest(Map<PermissionGroup, PermissionStatus> statusRequest) {
    final status = statusRequest[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Color(0xff161661),
          ),
          Icon(
            Icons.score,
            size: 30,
            color: Color(0xff161661),
          ),
          Icon(
            Icons.event,
            size: 30,
            color: Color(0xff161661),
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Color(0xff161661),
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Color(0xff161661),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xff161661),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    if (_page == 0) {
      return new Dashboard();
    } else if (_page == 1) {
      return new ListDonation();
    } else if (_page == 2) {
      return new ListMeeting();
    } else if (_page == 3) {
      return new ListChat();
    } else if (_page == 4) {
      return new Account();
    }
  }
}
