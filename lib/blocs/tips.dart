import 'package:lentera_lipuku/repositories/repository.dart';

class TipsBloc {
  final _repository = Repository();

  getDataTips() {
    return _repository.getDataTips();
  }

  getDataTipsByCode(code) {
    return _repository.getDataTipsByCode(code);
  }

  getDataTipsByLimitThree() {
    return _repository.getDataTipsByLimitThree();
  }
}

final tipsBloc = new TipsBloc();
