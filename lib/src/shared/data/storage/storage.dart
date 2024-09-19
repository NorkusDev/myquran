import 'package:equatable/equatable.dart';

abstract class Storage {
  Future<void> write(StorageValue data);
  Future<String?> read(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

class StorageValue extends Equatable {
  final String key;
  final String value;

  const StorageValue({
    required this.key,
    required this.value,
  });

  @override
  List<Object> get props => [key, value];
}
