import 'package:lentera_lipuku/repositories/repository.dart';

class KamiBloc {
  final _repository = Repository();

  getDataKamiByDivitionAndStatus(divition, status) {
    return _repository.getDataKamiByDivitionAndStatus(divition, status);
  }

  getDataKamiByCode(code) {
    return _repository.getDataKamiByCode(code);
  }

  getDataKamiByLimitThree() {
    return _repository.getDataKamiByLimitThree();
  }
}

final kamiBloc = KamiBloc();
