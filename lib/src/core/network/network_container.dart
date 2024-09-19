import 'package:dartz/dartz.dart';

import '../../shared/data/response.dart';
import '../exception/app_exception.dart';

/// Enum representing different types of HTTP request methods.
enum RequestType {
  /// HTTP GET request.
  get,

  /// HTTP POST request.
  post
}

/// Enum representing different types of request headers.
enum HeadersType {
  /// JSON headers.
  json,

  /// File headers.
  file,

  /// Other headers.
  other
}

/// Abstract class defining the contract for network operations.
///
/// The [NetworkContainer] class outlines methods and properties needed to
/// perform network requests, manage headers, and access configuration details.
///
/// Implementations should provide concrete details for network requests
/// and header management, ensuring that methods handle HTTP GET and POST requests
/// according to the specified [HeadersType].
abstract class NetworkContainer {
  /// The base URL used for network requests.
  ///
  /// This should be overridden in concrete implementations to provide
  /// the base URL for the API or service being accessed.
  String get baseUrl;

  /// A map of default headers for network requests.
  ///
  /// This should be overridden in concrete implementations to provide
  /// any default headers that should be included with network requests.
  Map<String, Object> get headers;

  /// Updates the headers with the provided data.
  ///
  /// This method allows updating or adding headers to the existing
  /// header map. The [data] parameter is a map of headers to be added
  /// or updated.
  ///
  /// Example:
  /// ```dart
  /// updateHeader({
  ///   'Authorization': 'Bearer token',
  /// });
  /// ```
  void updateHeader(Map<String, dynamic> data);

  /// Sends an HTTP GET request to the specified endpoint.
  ///
  /// This method performs a GET request to the given [endpoint] and
  /// handles the headers according to the specified [HeadersType].
  /// Optionally, query parameters can be included in the request.
  ///
  /// Returns an [Either] containing either an [AppException] if an error
  /// occurs, or a [Response] if the request is successful.
  ///
  /// [endpoint] The endpoint to send the GET request to.
  /// [header] The type of headers to include in the request.
  /// [queryParameter] Optional query parameters to include in the request.
  Future<Either<AppException, Response>> get(String endpoint,
      {required HeadersType header, Map<String, dynamic>? queryParameter});

  /// Sends an HTTP POST request to the specified endpoint.
  ///
  /// This method performs a POST request to the given [endpoint] and
  /// handles the headers according to the specified [HeadersType].
  /// Optionally, request body data can be included.
  ///
  /// Returns an [Either] containing either an [AppException] if an error
  /// occurs, or a [Response] if the request is successful.
  ///
  /// [endpoint] The endpoint to send the POST request to.
  /// [header] The type of headers to include in the request.
  /// [data] Optional data to include in the request body.
  Future<Either<AppException, Response>> post(String endpoint,
      {required HeadersType header, Map<String, dynamic>? data});
}
