import 'package:lentera_lipuku/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class EventsBloc {
  final _repository = new Repository();

  get allEvents {
    return _repository.getDataEvents();
  }
}

final blocEvent = new EventsBloc();
