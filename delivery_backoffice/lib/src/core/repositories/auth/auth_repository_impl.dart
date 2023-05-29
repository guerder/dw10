import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../models/auth_model.dart';
import '../../exceptions/repository_exception.dart';
import '../../exceptions/unauthorized_exception.dart';
import '../../rest_client/custom_dio.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  AuthRepositoryImpl(this._dio);
  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await _dio.unauth().post(
        '/auth',
        data: {'email': email, 'password': password, 'admin': true},
      );

      return AuthModel.fromMap(result.data);
    } catch (e, s) {
      if (e is DioError && e.response?.statusCode == 403) {
        log('Login ou senha inválidos', error: e, stackTrace: s);
        throw UnauthorizedException();
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
