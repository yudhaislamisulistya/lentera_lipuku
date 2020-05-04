import 'package:lentera_lipuku/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc {
  final _repository = new Repository();
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _content = BehaviorSubject<String>();
  final _create_at = BehaviorSubject<String>();

  Function(String) get updateName {
    return _name.sink.add;
  }

  Function(String) get updateContent {
    return _content.sink.add;
  }

  Function(String) get updateCreateAt {
    return _create_at.sink.add;
  }

  Function(String) get updateEmail {
    return _email.sink.add;
  }

  get allTodo {
    return _repository.getDataChatByGroupCode(_email.value);
  }

  addSaveTodo(chatData) {
    _repository.addDataChat(chatData);
  }
}

final blocChat = new ChatBloc();
