class MockException implements Exception {
  final String message;
  MockException({this.message = ''});
}

class ServerException implements Exception {
  final int code;
  final String message;
  ServerException({this.code = 0, this.message = ''});
}

class OtherException implements Exception {
  final String message;
  OtherException({this.message = ''});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = ''});
}
