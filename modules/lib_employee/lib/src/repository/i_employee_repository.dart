import 'package:dartz/dartz.dart';
import 'package:lib_common/lib_common.dart';

abstract class IEmployeeRepository {
  Future<Either<ApiFailure, List<Employee>>> getEmployeeList();
  Future<Either<ApiFailure, List<Employee>>> saveEmployee({
    required Employee employee,
    required bool isEdit,
  });
  Future<Either<ApiFailure, List<Employee>>> deleteEmployee({
    required Employee employee,
  });
}
