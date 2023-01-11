import 'dart:developer';
import 'package:dio/dio.dart';

import '../variables/app.dart';
import '../models/auth_model.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<AuthModel?> loginAction(account) async {
    try {
      FormData fd = await new FormData.fromMap(account);
      Response userData =
          await _dio.postUri(Uri.parse(baseUrl + auth.login), data: fd);
      AuthModel user = AuthModel.fromJson(userData.data['data']);
      return user;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> registerAction(account) async {
    try {
      FormData fd = await new FormData.fromMap(account);

      Response userData =
          await _dio.postUri(Uri.parse(baseUrl + auth.register), data: fd);
      return userData.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
