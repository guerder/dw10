import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/repositories/order/order_repository.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';

part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
  showDetailModal,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;

  OrderControllerBase(this._orderRepository) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @readonly
  OrderStateStatus _status = OrderStateStatus.initial;

  late final DateTime _today;

  @readonly
  OrderStatus? _statusFilter;

  @readonly
  List<OrderModel> _orders = [];

  @readonly
  String? _errorMessage;

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStatus.loading;
      _orders = await _orderRepository.findAllOrders(_today, _statusFilter);
      _status = OrderStateStatus.loaded;
    } on Exception catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      _status = OrderStateStatus.error;
      _errorMessage = 'Erro ao buscar pedidos do dia';
    }
  }

  @action
  Future<void> showDetailModal(OrderModel model) async {
    _status = OrderStateStatus.loading;
    await Future.delayed(Duration.zero);
    _status = OrderStateStatus.showDetailModal;
  }
}
