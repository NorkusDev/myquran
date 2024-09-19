import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constant/app_strings.dart';

abstract class NetworkChecker {
  Future<bool> get isConnected;
  Future<bool> haveConnection();
}

class NetworkCheckerImpl implements NetworkChecker {
  @override
  Future<bool> haveConnection() async {
    final networkInfo = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(seconds: 1),
      useDefaultOptions: false,
      customCheckOptions: [
        AddressCheckOption(
          uri: Uri(
            scheme: 'https',
            host: AppConstant.hostUrl,
          ),
          timeout: const Duration(
            seconds: 10,
          ),
        )
      ],
    );
    final status = await networkInfo.hasConnection;
    return status;
  }

  @override
  Future<bool> get isConnected => haveConnection();
}
