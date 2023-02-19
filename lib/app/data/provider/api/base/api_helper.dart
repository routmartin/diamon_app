import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../component/widget/base_toast.dart';
import '../../../../routes/app_pages.dart';
import '../../storage/storage_token.dart';
import 'api_error.dart';
import 'api_key.dart';

export 'package:dio/dio.dart';
export 'package:get/instance_manager.dart';

export '../base/api_key.dart';

class ApiBaseHelper {
  static final logger = PrettyDioLogger(
    requestHeader: false,
    queryParameters: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
    error: true,
    showProcessingTime: false,
    showCUrl: false,
    canShowLog: false,
  );

  static final modelMappingErrorObj = ApiError(
      ApiErrorStatus.mapModelError, ApiMessage(statusCode: 400, message: ''));

  final _apiBaseWithHeader = _addInterceptorsWithHeader(_createDio());

  final _apiBaseNoHeader = _addInterceptorsWithoutHeader(_createDio());

  final defaultErrorObj = ApiError(ApiErrorStatus.somethingWentWrong,
      ApiMessage(statusCode: 400, message: ''));
  Future deleteMethodHeader(String endPoint,
      {Map<String, dynamic>? body}) async {
    try {
      Response response = await _apiBaseWithHeader.delete(
        endPoint,
        data: body,
      );
      return response;
    } on DioError catch (e) {
      return dioErrorHandler(e);
    } catch (e) {
      return throw defaultErrorObj;
    }
  }

  //** To handle all error that occure */
  Future<ApiError> dioErrorHandler(DioError exc) async {
    final ApiMessage apiMessage = exc.response == null
        ? ApiMessage(statusCode: 400, message: 'message')
        : ApiMessage.fromJson(exc.response?.data);
    if (exc.error is SocketException) {
      return throw ApiError(ApiErrorStatus.noInternet, apiMessage);
    } else {
      switch (exc.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          return throw ApiError(ApiErrorStatus.errorRequest, apiMessage);
        case DioErrorType.cancel:
          return throw ApiError(ApiErrorStatus.cancelRequest, apiMessage);
        case DioErrorType.response:
          // Expire Token
          if (apiMessage.statusCode == 4410) {
            await Get.find<StorageToken>().regenerateToken().then((isSuccess) {
              if (isSuccess) {
                return throw ApiError(ApiErrorStatus.errorRequest, apiMessage);
              }
            });
            // Invalid Token -> remove token from local storage and log user out
          } else if (apiMessage.statusCode == 4400) {
            Get.find<StorageToken>()
                .removeTokenFromStorage()
                .then((_) => Get.offAndToNamed(Routes.LOGIN));
          } else {
            if (apiMessage.statusCode == 500) {
              BaseToast.removeAllBaseToast();
              BaseToast.showErorrBaseToast(apiMessage.message);
            }
            return throw ApiError(ApiErrorStatus.errorRequest, apiMessage);
          }
          break;
      }
    }
    return throw ApiError(ApiErrorStatus.errorRequest, apiMessage);
  }

  CancelToken getCancelToken({Map<String, dynamic>? body}) {
    return body!.containsKey(AppApiKey.cancelToken)
        ? body[AppApiKey.cancelToken]
        : body;
  }

  Future getMethod(String endPoint, {Map<String, dynamic>? body}) async {
    try {
      Response response = await _apiBaseNoHeader.get(
        endPoint,
        queryParameters: body,
      );
      return response;
    } on DioError catch (e) {
      return dioErrorHandler(e);
    } catch (e) {
      return throw defaultErrorObj;
    }
  }

  Future getMethodHeader(String endPoint, {Map<String, dynamic>? body}) async {
    try {
      Response response = await _apiBaseWithHeader.get(
        endPoint,
        queryParameters: body,
      );
      return response;
    } on DioError catch (e) {
      return dioErrorHandler(e);
    } catch (e) {
      return throw ApiError(ApiErrorStatus.somethingWentWrong,
          ApiMessage(statusCode: 400, message: ''));
    }
  }

  Future postMethod(String endPoint, {Map<String, dynamic>? body}) async {
    try {
      Response response = await _apiBaseNoHeader.post(
        endPoint,
        data: body,
      );
      return response;
    } on DioError catch (e) {
      return dioErrorHandler(e);
    } catch (e) {
      return throw defaultErrorObj;
    }
  }

  Future postMethodHeader(String endPoint, {data}) async {
    try {
      Response response = await _apiBaseWithHeader.post(endPoint, data: data);
      return response;
    } on DioError catch (e) {
      return dioErrorHandler(e);
    } catch (e) {
      return throw defaultErrorObj;
    }
  }

  Future putMethodHeader(String endPoint, {Map<String, dynamic>? body}) async {
    try {
      Response response = await _apiBaseWithHeader.put(
        endPoint,
        data: body,
      );
      return response;
    } on DioError catch (e) {
      return dioErrorHandler(e);
    } catch (e) {
      return throw defaultErrorObj;
    }
  }

  static Dio _addInterceptorsWithHeader(Dio dio) {
    return dio
      ..interceptors.add(logger)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            String token = StorageToken.readToken();
            options.headers.addAll({"authorization": "Bearer $token"});
            handler.next(options);
          },
        ),
      );
  }

  static Dio _addInterceptorsWithoutHeader(Dio dio) {
    return dio
      ..interceptors.add(logger)
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
      ));
  }

  static Dio _createDio() {
    return Dio()
      ..options.baseUrl = AppApiKey.baseUrl
      ..options.connectTimeout = 5000 // one minute
      ..options.receiveTimeout = 5000
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..options.headers = {"Accept": "application/json"};
  }
}
