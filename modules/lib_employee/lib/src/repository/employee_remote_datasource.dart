

import 'package:lib_common/lib_common.dart';

import 'employee_dto.dart';
import 'employee_storage.dart';

class EmployeeRemoteDataSource {

  EmployeeRemoteDataSource({
    required this.exceptionHandler,
    required this.storage,
  });
  final EmployeeStorage storage;
  final DataSourceExceptionHandler exceptionHandler;

  Future<List<Employee>> getEmployeeList() async {
    return await exceptionHandler.handle(() async {
      final List<EmployeeDto> res = storage.getAll();
      return res.map((EmployeeDto e) => e.toDomain).toList();
    });
  }

  Future<List<Employee>> saveEmployee({
    required Employee employee,
    required bool isEdit,
  }) async {
    return await exceptionHandler.handle(() async {
      storage.set(EmployeeDto.fromDomain(employee));
      return getEmployeeList();
    });
  }

  Future<List<Employee>> removeEmployee({
    required Employee employee,
  }) async {
    return await exceptionHandler.handle(() async {
      storage.delete(EmployeeDto.fromDomain(employee));
      return getEmployeeList();
    });
  }
}
