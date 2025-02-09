import 'package:dartz/dartz.dart';
import 'package:lib_common/lib_common.dart';
import 'employee_remote_datasource.dart';
import 'i_employee_repository.dart';

class EmployeeRepository extends IEmployeeRepository {

  EmployeeRepository({
    required this.remoteDataSource,
  });
  final EmployeeRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, List<Employee>>> getEmployeeList() async {
    try {
      final List<Employee> employeeList =
          await remoteDataSource.getEmployeeList();

      return Right(employeeList);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e));
    }
  }

  @override
  Future<Either<ApiFailure, List<Employee>>> saveEmployee(
      {required Employee employee, required bool isEdit}) async {
    try {
      final List<Employee> employeeList = await remoteDataSource.saveEmployee(
        employee: employee,
        isEdit: isEdit,
      );

      return Right(employeeList);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e));
    }
  }

  @override
  Future<Either<ApiFailure, List<Employee>>> deleteEmployee(
      {required Employee employee}) async {
    try {
      final List<Employee> employeeList = await remoteDataSource.removeEmployee(
        employee: employee,
      );

      return Right(employeeList);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e));
    }
  }
}
