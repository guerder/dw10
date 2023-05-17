import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/repositories/payment_type/payment_type_repository.dart';
import '../../models/payment_type_model.dart';
part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
  saved,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  @readonly
  PaymentTypeStateStatus _status = PaymentTypeStateStatus.initial;

  @readonly
  List<PaymentTypeModel> _paymentTypes = [];

  @readonly
  String? _errorMessage;

  @readonly
  PaymentTypeModel? _paymentTypeSelected;

  @readonly
  bool? _filterEnabled;

  @action
  void changeFilter(bool? enabled) => _filterEnabled = enabled;

  @action
  Future<void> loadPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTypeRepository.findAll(_filterEnabled);
      _status = PaymentTypeStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar as formas de pagamento', error: e, stackTrace: s);
      _errorMessage = 'Erro ao carregar as formas de pagamento';
      _status = PaymentTypeStateStatus.error;
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel payment) async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = payment;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    int? id,
    required String name,
    required String acronym,
    required bool enabled,
  }) async {
    _status = PaymentTypeStateStatus.loading;
    final paymentTypeModel = PaymentTypeModel(
      id: id,
      name: name,
      acronym: acronym,
      enabled: enabled,
    );

    await _paymentTypeRepository.save(paymentTypeModel);
    _status = PaymentTypeStateStatus.saved;
  }
}
