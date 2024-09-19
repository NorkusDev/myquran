import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage.dart';

class SecureStorageService implements Storage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @override
  Future<String?> read(String key) async {
    final read = await storage.read(key: key);
    return read;
  }

  @override
  Future<void> write(StorageValue data) async {
    final write = await storage.write(key: data.key, value: data.value);
    return write;
  }

  @override
  Future<void> clear() async {
    final clear = await storage.deleteAll();
    return clear;
  }

  @override
  Future<void> remove(String key) async {
    final remove = await storage.delete(key: key);
    return remove;
  }
}
