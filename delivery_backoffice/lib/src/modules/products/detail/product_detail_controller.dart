import 'dart:developer';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';

import '../../../core/repositories/product/product_repository.dart';
import '../../../models/product_model.dart';
part 'product_detail_controller.g.dart';

enum ProductDetailStateStatus {
  initial,
  loading,
  loaded,
  error,
  errorLoadProduct,
  deleted,
  uploaded,
  saved,
}

class ProductDetailController = ProductDetailControllerBase
    with _$ProductDetailController;

abstract class ProductDetailControllerBase with Store {
  final ProductRepository _productRepository;

  ProductDetailControllerBase(this._productRepository);

  @readonly
  var _status = ProductDetailStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  String? _imagePath;

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDetailStateStatus.loading;
    _imagePath = await _productRepository.uploadImageProduct(file, fileName);
    _status = ProductDetailStateStatus.uploaded;
  }

  @action
  Future<void> save(String name, double price, String description) async {
    _status = ProductDetailStateStatus.loading;
    try {
      final productModel = ProductModel(
        name: name,
        price: price,
        description: description,
        image: _imagePath!,
        enabled: true,
      );
      await _productRepository.save(productModel);
      _status = ProductDetailStateStatus.saved;
    } catch (e, s) {
      log('Erro ao salvar o produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.error;
      _errorMessage = 'Erro ao salvar o produto';
    }
  }
}
