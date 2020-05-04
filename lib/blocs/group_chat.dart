import 'package:lentera_lipuku/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class GroupChatBloc {
  final _repository = Repository();
  // final _todoFetcher = PublishSubject<List<GroupChatModel>>();
  final _code = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _create_at = BehaviorSubject<String>();
  final _updated_at = BehaviorSubject<String>();

  Function(String) get updateCode {
    return _code.sink.add;
  }

  Function(String) get updateName {
    return _name.sink.add;
  }

  Function(String) get updateCreateAt {
    return _create_at.sink.add;
  }

  Function(String) get updateUpdatedAt {
    return _updated_at.sink.add;
  }

  get allTodo {
    return _repository.getDataGroupChat();
  }

  dispose() {
    _code.close();
    _name.close();
    _create_at.close();
    _updated_at.close();
  }
}

final bloc = GroupChatBloc();
