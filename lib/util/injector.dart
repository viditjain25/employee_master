import 'package:lib_common/src/utility/app_router.dart';
import 'package:lib_employee/lib_employee.dart';
import 'package:lib_style/lib_style.dart';
import 'package:lib_common/lib_common.dart';

class Injector {
  static Future<void> setupDI() async {
    getIt.registerLazySingleton(() => Resources(AppThemeMode.light));
    getIt.registerLazySingleton(() => AppRouter());
    getIt.registerLazySingleton(() => NavigationService());
    getIt.registerLazySingleton(() => DataSourceExceptionHandler());
    getIt.registerLazySingleton(
          () => EmployeeStorage(),
    );
    getIt.registerLazySingleton(
          () => EmployeeRemoteDataSource(
        storage: getIt<EmployeeStorage>(),
        exceptionHandler: getIt<DataSourceExceptionHandler>(),
      ),
    );
    getIt.registerLazySingleton(
          () => EmployeeRepository(
        remoteDataSource: getIt<EmployeeRemoteDataSource>(),
      ),
    );

    getIt.registerLazySingleton(
          () => EmployeeBloc(
        repository: getIt<EmployeeRepository>(),
      ),
    );
  }
}
