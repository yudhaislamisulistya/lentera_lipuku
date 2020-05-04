import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  // Data Meeting

  getDataMeeting() {
    return Firestore.instance
        .collection("meetings")
        .orderBy("create_at", descending: true)
        .snapshots();
  }

  Future<void> addMeetingPresentByEmail(meetingPresent) async {
    Firestore.instance
        .collection('meeting_present')
        .add(meetingPresent)
        .catchError((e) {
      print(e);
    });
  }

  // Data Donation
  getDataDonation() {
    return Firestore.instance
        .collection("donations")
        .orderBy('create_at', descending: true)
        .snapshots();
  }

  getDataListDonation() {
    return Firestore.instance
        .collection("list_donations")
        .orderBy("create_at", descending: true)
        .snapshots();
  }

  getDataListDonationByCodeDonation(code) {
    return Firestore.instance
        .collection("donations")
        .where("code", isEqualTo: code)
        .orderBy("create_at", descending: true)
        .snapshots();
  }

  // Data Kami
  getDataKamiByDivitionAndStatus(divition, status) {
    return Firestore.instance
        .collection('kami')
        .where('divition', isEqualTo: divition)
        .where('status', isEqualTo: status)
        .orderBy('create_at', descending: true)
        .snapshots();
  }

  getDataKamiByLimitThree() {
    return Firestore.instance.collection("kami").limit(3).snapshots();
  }

  getDataKamiByCode(code) {
    return Firestore.instance
        .collection("kami")
        .where('code', isEqualTo: code)
        .snapshots();
  }

  getDataGroupChat() {
    return Firestore.instance
        .collection('group_chat')
        .orderBy('create_at', descending: true)
        .snapshots();
  }

  getDataEvents() {
    return Firestore.instance
        .collection('events')
        .orderBy('create_at', descending: true)
        .snapshots();
  }

  // Tips
  getDataTips() {
    return Firestore.instance
        .collection("tips")
        .orderBy("create_at", descending: true)
        .snapshots();
  }

  getDataTipsByCode(code) {
    return Firestore.instance
        .collection("tips")
        .where("code", isEqualTo: code)
        .orderBy("create_at", descending: true)
        .snapshots();
  }

  getDataTipsByLimitThree() {
    return Firestore.instance.collection("tips").limit(3).snapshots();
  }

  getDataChatByGroupCode(code) {
    return Firestore.instance
        .collection('chat')
        .where('group_code', isEqualTo: code)
        .orderBy('create_at', descending: false)
        .snapshots();
  }

  Future<void> addDataChat(chatData) async {
    Firestore.instance.collection('chat').add(chatData).catchError((e) {
      print(e);
    });
  }

  deleteDataChat(docId) async {
    return Firestore.instance
        .collection('chat')
        .document(docId)
        .delete()
        .catchError((r) {
      print(r);
    });
  }
}
