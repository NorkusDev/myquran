import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  final String identifier;

  const AppException({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });
  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }

  @override
  List<Object?> get props => [message, statusCode, identifier];
}

class ServerFailureException extends Equatable implements AppException {
  final String msg;
  const ServerFailureException(this.msg);

  @override
  String get identifier => 'Server Failure Exception';

  @override
  String get message => msg;

  @override
  List<Object?> get props => [message, statusCode, identifier, msg];

  @override
  int get statusCode => 500;
}

class CacheFailureException extends Equatable implements AppException {
  final String msg;
  const CacheFailureException(this.msg);

  @override
  String get identifier => 'Cache Failure Exception';

  @override
  String get message => msg;

  @override
  List<Object?> get props => [message, statusCode, identifier, msg];

  @override
  int get statusCode => 100;
}
