import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../shared/data/response.dart' as response;
import '../constant/app_strings.dart';
import '../exception/app_exception.dart';
import '../mixins/exception_handler_mixin.dart';
import 'interceptor.dart';
import 'network_container.dart';

/// A concrete implementation of [NetworkContainer] using the Dio library.
///
/// This class implements network operations using Dio and provides methods for
/// performing HTTP GET and POST requests. It also integrates [ExceptionHandlerMixin]
/// for handling exceptions that may occur during network operations.
///
/// [DioNetworkContainer] requires an instance of [Dio] for performing HTTP requests.
///
/// Usage:
/// ```dart
/// final dio = Dio();
/// final networkContainer = DioNetworkContainer(dio);
/// final result = await networkContainer.get('/endpoint');
/// ```
class DioNetworkContainer extends NetworkContainer with ExceptionHandlerMixin {
  final Dio dio;

  /// Creates an instance of [DioNetworkContainer].
  ///
  /// [dio] An instance of Dio used for making network requests.
  DioNetworkContainer(this.dio) {
    dio.interceptors.clear();
    if (AppConstantX.isDevelopment) {
      dio.interceptors.add(PrettyDioLogger(responseBody: false));
    }
    dio.options = dioBaseOption;
    dio.interceptors.addAll([ErrorInterceptor()]);
  }

  @override
  String get baseUrl => AppConstant.baseUrl;

  /// Provides the base options for Dio, including the base URL and headers.
  BaseOptions get dioBaseOption => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (int? status) {
          return status != null;
          // return status != null && status >= 200 && status < 300;
        },
      );

  @override
  Map<String, Object> get headers => {
        'accept': Headers.jsonContentType,
        'content-type': Headers.jsonContentType,
      };

  /// Updates the headers with additional data.
  ///
  /// The [data] parameter is a map of additional headers to be merged with
  /// the existing headers. This method combines the new headers with the
  /// default headers and returns the updated header map.
  ///
  /// Example:
  /// ```dart
  /// final updatedHeaders = updateHeader({
  ///   'Authorization': 'Bearer token',
  /// });
  /// ```
  @override
  Map<String, dynamic> updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    return header;
  }

  /// Sends an HTTP GET request to the specified endpoint.
  ///
  /// This method performs a GET request to the given [endpoint], including
  /// query parameters if provided. It uses [handleException] to handle
  /// potential errors and exceptions.
  ///
  /// [endpoint] The endpoint to send the GET request to.
  /// [header] The type of headers to include in the request.
  /// [queryParameter] Optional query parameters to include in the request.
  @override
  Future<Either<AppException, response.Response>> get(String endpoint,
      {required HeadersType header,
      Map<String, dynamic>? queryParameter}) async {
    final res = await handleException(
      () => dio.get(
        endpoint,
        queryParameters: queryParameter,
      ),
      endpoint: endpoint,
    );
    return res;
  }

  /// Sends an HTTP POST request to the specified endpoint.
  ///
  /// This method performs a POST request to the given [endpoint], including
  /// data in the request body if provided. It uses [handleException] to handle
  /// potential errors and exceptions.
  ///
  /// [endpoint] The endpoint to send the POST request to.
  /// [header] The type of headers to include in the request.
  /// [data] Optional data to include in the request body.
  @override
  Future<Either<AppException, response.Response>> post(String endpoint,
      {required HeadersType header, Map<String, dynamic>? data}) async {
    final res = await handleException(
      () => dio.post(
        endpoint,
        data: data,
      ),
      endpoint: endpoint,
    );
    return res;
  }
}
