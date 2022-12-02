import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:world_cup/providers/user_provider.dart';
import 'package:world_cup/resources/api_config.dart';
import 'package:world_cup/utility/scaffold_messenger.dart';
import 'package:world_cup/utility/snackbar.dart';

class Api {
  final dio = createDio;
  // final tokenDio = Dio(BaseOptions(baseUrl: ApiConfig().appConfig));
  final authDio = createAuthDio;
  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio get createDio {
    var dio = Dio(BaseOptions(
      baseUrl: ApiConfig().appConfig,
      receiveTimeout: 120000, // 15 seconds
      connectTimeout: 120000,
      sendTimeout: 120000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  static Dio get createAuthDio {
    var authDio = Dio(BaseOptions(
      baseUrl: ApiConfig().authConfig,
      receiveTimeout: 120000, // 15 seconds
      connectTimeout: 120000,
      sendTimeout: 120000,
    ));

    authDio.interceptors.addAll({
      AppInterceptors(authDio),
    });
    return authDio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio? dio;

  // final AuthController authController = Get.put(AuthController());
  // final UserInfoController userInfoController = Get.put(UserInfoController());
  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['accept-encoding'] = 'json';
    if (UserData.instance.user == null) {
      return handler.next(options);
    }

    String token = UserData.instance.user!.token ?? '';
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print(
    //   'RESPONSE[${response.statusCode}] => Data: ${response.data}',
    // );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // final LoaderController loaderController = Get.find();
    // print(err.error);
    // print(err.message);
    // print(err.response);
    // print('errrrrrrrrrrrrrrrrrrrr ${err.requestOptions.path}');
    Messenger.instance.showSnackBar(err.message);
    if (err.response?.statusCode == 401) {
      // if (Get.currentRoute != LoginScreen.routeName) authController.logOut();
    } else if (err.response?.statusCode == 500) {
      // msgHandlerController.showErrorMessage('serverError');
    }

    if (err.response == null) {
      // msgHandlerController.showErrorMessage('timeOut');
    } else {
      // var error = ErrorModel.fromJson(err.response?.data);
      // msgHandlerController.showErrorMessage(error.code);
    }
    // handler.next(err);
    return super.onError(err, handler);
  }
}
