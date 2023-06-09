import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../models/product_model.dart';
import '../../exceptions/repository_exception.dart';
import '../../rest_client/custom_dio.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final CustomDio _dio;

  ProductRepositoryImpl(this._dio);

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await _dio.auth().put('/products/$id', data: {'enabled': false});
    } catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final productsResult = await _dio.auth().get(
        '/products',
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );
      return (productsResult.data as List)
          .map((p) => ProductModel.fromMap(p))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final productResult = await _dio.auth().get('/products/$id');
      return ProductModel.fromMap(productResult.data);
    } catch (e, s) {
      log('Erro ao buscar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produto');
    }
  }

  @override
  Future<void> save(ProductModel model) async {
    try {
      final client = _dio.auth();
      final data = model.toMap();
      if (model.id != null) {
        await client.put('/products/${model.id}', data: data);
      } else {
        await client.post('/products', data: data);
      }
    } catch (e, s) {
      log('Erro ao salvar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar produto');
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String filename) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: filename),
      });

      final response = await _dio.auth().post('/uploads', data: formData);
      return response.data['url'] as String;
    } catch (e, s) {
      log('Erro ao fazer upload do arquivo', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao fazer upload do arquivo');
    }
  }
}
