import 'package:hive_flutter/hive_flutter.dart';
import 'package:lib_common/lib_common.dart';

import 'employee_dto.dart';


class EmployeeStorage {

  EmployeeStorage();
  static const String _boxName = hiveBoxName;

  late Box<EmployeeDto> _employeeBox;

  int get employeeBoxSize => _employeeBox.length;

  Future<void> init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(EmployeeDtoAdapter());
      _employeeBox = await Hive.openBox(
        _boxName,
      );
    } catch (e) {
      await Hive.deleteBoxFromDisk(_boxName);
      await init();
    }
  }

  List<EmployeeDto> getAll() {
    try {
      return _employeeBox.values.toList();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> set(EmployeeDto employee) async {
    try {
      employee.id.isNotEmpty
          ? await _employeeBox.put(int.parse(employee.id), employee)
          : await _employeeBox.add(employee);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> delete(EmployeeDto employee) async {
    try {
      await _employeeBox.delete(int.parse(employee.id));
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
