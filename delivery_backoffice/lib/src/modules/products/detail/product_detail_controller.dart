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

  @readonly
  ProductModel? _productModel;

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
        id: _productModel?.id,
        name: name,
        price: price,
        description: description,
        image: _imagePath!,
        enabled: _productModel?.enabled ?? true,
      );
      await _productRepository.save(productModel);
      _status = ProductDetailStateStatus.saved;
    } on Exception catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      _status = ProductDetailStateStatus.error;
      _errorMessage = 'Erro ao salvar o produto';
    }
  }

  @action
  Future<void> loadProduct(int? id) async {
    _status = ProductDetailStateStatus.loading;
    _productModel = null;
    _imagePath = null;
    try {
      if (id != null) {
        _productModel = await _productRepository.getProduct(id);
        _imagePath = _productModel!.image;
      }
      _status = ProductDetailStateStatus.loaded;
    } on Exception catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      _status = ProductDetailStateStatus.errorLoadProduct;
      _errorMessage = 'Erro ao carregar produto';
    }
  }

  @action
  Future<void> deleteProduct() async {
    _status = ProductDetailStateStatus.loading;
    try {
      if (_productModel != null && _productModel!.id != null) {
        await _productRepository.deleteProduct(_productModel!.id!);
      }
      _status = ProductDetailStateStatus.deleted;
    } on Exception catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      _status = ProductDetailStateStatus.error;
      _errorMessage = 'Erro ao deletar produto';
    }
  }
}
