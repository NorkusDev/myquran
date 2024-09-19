import 'package:dartz/dartz.dart';
import '../../../core/exception/app_exception.dart';

abstract class Usecase<Type, Params> {
  Future<Either<AppException, Type>> call(Params param);
}

abstract class StreamCase<Type, Params> {
  Stream<Either<AppException, Type>> call(Params param);
}
