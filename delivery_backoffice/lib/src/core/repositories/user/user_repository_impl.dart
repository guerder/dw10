import 'dart:developer';

import '../../../models/user_model.dart';
import '../../exceptions/repository_exception.dart';
import '../../rest_client/custom_dio.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CustomDio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Future<UserModel> getById(int id) async {
    try {
      final userResult = await _dio.auth().get('/users/$id');
      return UserModel.fromMap(userResult.data);
    } catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
}
