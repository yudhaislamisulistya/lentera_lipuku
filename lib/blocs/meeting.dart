import 'package:lentera_lipuku/repositories/repository.dart';

class MeetingBloc {
  final _repository = Repository();

  getDataMeeting() {
    return _repository.getDataMeeting();
  }

  addSaveMeetingPresentByEmail(meetingPresent) {
    _repository.addMeetingPresentByEmail(meetingPresent);
  }
}

final meetingBloc = new MeetingBloc();
