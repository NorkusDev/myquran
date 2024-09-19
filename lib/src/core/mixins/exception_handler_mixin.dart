import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../exception/app_exception.dart';
import '../network/network_container.dart';
import '../../shared/data/response.dart' as response;

/// A mixin that provides a standardized way to handle exceptions during network operations.
///
/// The [ExceptionHandlerMixin] wraps network calls in a try-catch block and returns errors
/// encapsulated in an [AppException]. It is intended for use with classes that handle
/// network requests, offering a clean and reusable approach to error handling.
///
/// Usage:
/// ```dart
/// class MyNetworkClass with ExceptionHandlerMixin {
///   final Dio dio;
///
///   MyNetworkClass(this.dio);
///
///   Future<Either<AppException, Response>> fetchData(String endpoint) async {
///     return handleException(() async {
///       final response = await dio.get(endpoint);
///       return response;
///     }, endpoint: endpoint);
///   }
/// }
/// ```
///
/// This mixin is typically used in conjunction with classes that extend or implement
/// [NetworkContainer].
/// mixin ExceptionHandlerMixin on NetworkContainer {
/// Handles exceptions that occur during network operations.
///
/// Executes the [handler] function and processes any exceptions that occur.
/// Returns an [Either] containing either a successful [response.Response] or an [AppException].
///
/// The [handler] function represents the network operation or any async function
/// that returns a [response.Response]. The [endpoint] parameter is optional and is used
/// for logging purposes, indicating the endpoint or context where the error occurred.
///
/// Example:
/// ```dart
/// final result = await handleException(() async {
///   final response = await dio.get(endpoint);
///   return response;
/// }, endpoint: endpoint);
/// ```
///
/// [endpoint] (optional) A string representing the endpoint or context for logging.

mixin ExceptionHandlerMixin on NetworkContainer {
  Future<Either<AppException, response.Response>>
      handleException<T extends Object>(
          Future<Response<dynamic>> Function() handler,
          {String endpoint = ''}) async {
    try {
      final res = await handler();
      return Right(
        response.Response(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage ?? "#?",
        ),
      );
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      log(e.runtimeType.toString());
      if (e.runtimeType == SocketException) {
        e as SocketException;
        message = 'Unable to connect to the server.';
        statusCode = 0;
        identifier = 'Socket Exception ${e.message}\n at  $endpoint';
      } else if (e.runtimeType == DioException) {
        e as DioException;
        message = e.response?.data?['message'] ?? 'Internal Error occurred';
        statusCode = 1;
        identifier = 'DioException ${e.message} \nat  $endpoint';
      } else {
        message = 'Error tidak dikenali';
        statusCode = 2;
        identifier = 'Error tidak dikenali ${e.toString()}\n at $endpoint';
      }

      return Left(
        AppException(
          message: message,
          statusCode: statusCode,
          identifier: identifier,
        ),
      );
    }
  }
}
