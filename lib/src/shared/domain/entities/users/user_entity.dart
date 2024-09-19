import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int statusCode;
  final String status;
  final String message;
  final DataUserEntity? data;
  const UserEntity({
    required this.statusCode,
    required this.status,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [statusCode, status, message, data];
}

class DataUserEntity extends Equatable {
  final String name;
  final String username;
  const DataUserEntity({
    required this.name,
    required this.username,
  });

  @override
  List<Object> get props => [name, username];
}
