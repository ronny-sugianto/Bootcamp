import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import '../Models/employee_model.dart';

import '../testing.dart';

class EmployeeController extends ResourceController {
  EmployeeController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getEmployee({@Bind.query('id') String id}) async {
    final employeeQuery = Query<Employee>(context);

    if (id != null) {
      final employeeQuery = Query<Employee>(context)
        ..where((emp) => emp.id).equalTo(id).toString();
      // final employee = await employeeQuery.fetchOne();
      // print(employee);
      // if (employee == null) {
      //   print('ONO');
      //   return Response.notFound(body: 'Not Found');
      // }

      //print(employee);
      //return Response.ok(employee);
    }
    print('COMEHERE');
    return Response.ok(await employeeQuery.fetch());
    // return Response.ok(employee);
  }

  // @Operation.get('id')
  // Future<Response> getEmployeeById({@Bind.path('id') String id}) async {
  //   final employeeQuery = Query<Employee>(context)
  //     ..where((emp) => emp.id).equalTo(id);
  //   final employee = await employeeQuery.fetchOne();
  //   if (employee == null) {
  //     return Response.notFound(body: 'Not Found');
  //   } else {
  //     return Response.ok(employee);
  //   }
  // }

  @Operation.post()
  Future<Response> create(@Bind.body() Employee body) async {
    //employee.add(body);
    return Response.ok(body);
  }

  @Operation.put('id')
  Future<Response> updateByName(
      @Bind.path('id') int id, @Bind.body() Employee body) async {
    // if (id < 0 || id > employee.length - 1) {
    //   return Response.notFound(body: 'Item not found');
    // }
    // employee[id] = body;
    // return Response.ok('Updated read');
  }

  @Operation.delete('id')
  Future<Response> delete(@Bind.path('id') int id) async {
    //   if (id < 0 || id > employee.length - 1) {
    //     return Response.notFound(body: 'Item not found.');
    //   }
    //   employee.removeAt(id);
    //   return Response.ok('Delete read.');
  }
}
