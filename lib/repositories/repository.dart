import 'package:lentera_lipuku/providers/firestore_provider.dart';

class Repository {
  final _firestoreProvider = new FirestoreProvider();

  Future<void> addDataChat(chatData) async {
    return _firestoreProvider.addDataChat(chatData);
  }

  getDataKamiByDivitionAndStatus(divition, status) {
    return _firestoreProvider.getDataKamiByDivitionAndStatus(divition, status);
  }

  getDataKamiByCode(code) {
    return _firestoreProvider.getDataKamiByCode(code);
  }

  getDataKamiByLimitThree() {
    return _firestoreProvider.getDataKamiByLimitThree();
  }

  getDataGroupChat() {
    return _firestoreProvider.getDataGroupChat();
  }

  getDataChatByGroupCode(code) {
    return _firestoreProvider.getDataChatByGroupCode(code);
  }

  getDataEvents() {
    return _firestoreProvider.getDataEvents();
  }

// Data Tips
  getDataTips() {
    return _firestoreProvider.getDataTips();
  }

  getDataTipsByCode(code) {
    return _firestoreProvider.getDataTipsByCode(code);
  }

  getDataTipsByLimitThree() {
    return _firestoreProvider.getDataTipsByLimitThree();
  }

  // Data Donation
  getDataDonation() {
    return _firestoreProvider.getDataDonation();
  }

  getDataListDonation() {
    return _firestoreProvider.getDataListDonation();
  }

  getDataListDonationByCodeDonation(code) {
    return _firestoreProvider.getDataListDonationByCodeDonation(code);
  }

  // Data Meeting
  getDataMeeting() {
    return _firestoreProvider.getDataMeeting();
  }

  addMeetingPresentByEmail(meetingPresent) {
    return _firestoreProvider.addMeetingPresentByEmail(meetingPresent);
  }
}
