import 'dart:developer';

import '../../../models/orders/order_model.dart';
import '../../../models/orders/order_status.dart';
import '../../exceptions/repository_exception.dart';
import '../../rest_client/custom_dio.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);
  @override
  Future<void> changeStatus(int id, OrderStatus status) async {
    try {
      await _dio.auth().put('/orders/$id', data: {'status': status.acronym});
    } catch (e, s) {
      log(
        'Erro ao alterar status do pedido para ${status.acronym}',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao alterar status do pedido para ${status.acronym}',
      );
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(
    DateTime date, [
    OrderStatus? status,
  ]) async {
    try {
      final ordersResult = await _dio.auth().get(
        '/orders',
        queryParameters: {
          'date': date.toIso8601String(),
          if (status != null) 'status': status.acronym,
        },
      );

      return (ordersResult.data as List)
          .map<OrderModel>((o) => OrderModel.fromMap(o))
          .toList();
    } catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar pedidos');
    }
  }

  @override
  Future<OrderModel> getById(int id) async {
    try {
      final orderResult = await _dio.auth().get('/orders/$id');
      return OrderModel.fromMap(orderResult.data);
    } catch (e, s) {
      log('Erro ao buscar pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar pedido');
    }
  }
}
