import 'dart:async';
import 'package:flutter/services.dart';

import 'api_failures.dart';
import 'exception.dart';

class FailureHandler {
  static ApiFailure handleFailure(Object error) {
    switch (error.runtimeType) {
      case MockException:
        return ApiFailure.other((error as MockException).message);
      case CacheException:
        return ApiFailure.other((error as CacheException).message);
      case ServerException:
        final message = (error as ServerException).message;
        return ApiFailure.serverError(message);
      case TimeoutException:
        return const ApiFailure.serverTimeout();
      case PlatformException:
        return ApiFailure.other('${(error as PlatformException).message}');
      case OtherException:
        return ApiFailure.other((error as OtherException).message);

      default:
        return ApiFailure.other(error.toString());
    }
  }
}
