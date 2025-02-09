class DataSourceExceptionHandler {
  Future<dynamic> handle(Function function) async {
    try {
      return  function();
    } catch (e) {
      rethrow;
    }
  }
}
