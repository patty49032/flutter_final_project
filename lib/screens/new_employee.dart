import 'package:flutter/material.dart';
import 'package:flutter_final_project/services/employee_service.dart';

import '../main.dart';

class NewEmployeeScreen extends StatelessWidget {
  final _itemName = TextEditingController();
  final _itemRole = TextEditingController();
  final _itemSalary = TextEditingController();

  final EmployeeService _employeeService = EmployeeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Name")),
              controller: _itemName,
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Role")),
              controller: _itemRole,
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Salary")),
              controller: _itemSalary,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _employeeService.addItem2Firebase(_itemName.text, {
                    "name": _itemName.text,
                    "role": _itemRole.text,
                    "salary": _itemSalary.text
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Add Employee Success")));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "Employee Salary Database")));
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  // _addItem() {
  //   _employeeService.addItem2Firebase(_itemName.text, {
  //     "name": _itemName.text,
  //     "role": _itemRole.text,
  //     "salary": _itemSalary.text
  //   });
  // }
}
