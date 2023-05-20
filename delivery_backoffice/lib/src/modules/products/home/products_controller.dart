import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../../core/repositories/product/product_repository.dart';
import '../../../models/product_model.dart';
part 'products_controller.g.dart';

enum ProductStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProductsController = ProductsControllerBase with _$ProductsController;

abstract class ProductsControllerBase with Store {
  final ProductRepository _productRepository;

  ProductsControllerBase(this._productRepository);

  @readonly
  ProductStateStatus _status = ProductStateStatus.initial;

  @readonly
  List<ProductModel> _products = [];

  @readonly
  String? _filterName;

  @action
  Future<void> filterByName(String name) async {
    _filterName = name;
    await loadProducts();
  }

  @action
  Future<void> loadProducts() async {
    try {
      _status = ProductStateStatus.loading;
      _products = await _productRepository.findAll(_filterName);
      _status = ProductStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar productos', error: e, stackTrace: s);
      _status = ProductStateStatus.error;
    }
  }
}
