import 'testing.dart';
import 'package:testing/Controllers/employee_controller.dart';

class TestingChannel extends ApplicationChannel {
  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        'root', 'cobacoba', 'localhost', 5432, 'my_backend');
    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint => Router()
    ..route("/employee/[:id]").link(() => EmployeeController(context));
}
