import 'package:lentera_lipuku/repositories/repository.dart';

class DonationBloc {
  final _repository = Repository();

  getDataDonation() {
    return _repository.getDataDonation();
  }

  getDataListDonation() {
    return _repository.getDataListDonation();
  }

  getDataListDonationByCodeDonation(code) {
    return _repository.getDataListDonationByCodeDonation(code);
  }
}

final donationBloc = DonationBloc();
