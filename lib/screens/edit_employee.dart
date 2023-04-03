import 'package:flutter/material.dart';
import 'package:flutter_final_project/services/employee_service.dart';

import '../main.dart';

class EditItemScreen extends StatefulWidget {
  late String documentid;
  final _itemName = TextEditingController();
  final _itemRole = TextEditingController();
  final _itemSalary = TextEditingController();
  EditItemScreen(
      String documentid, String itemname, String itemrole, String itemsalary) {
    documentid = documentid;
    _itemName.text = itemname;
    _itemRole.text = itemrole;
    _itemSalary.text = itemsalary;
  }

  @override
  State<EditItemScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditItemScreen> {
  final EmployeeService _employeeService = EmployeeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._itemName,
              decoration: const InputDecoration(label: Text("Name")),
              readOnly: true,
            ),
            TextField(
              controller: widget._itemRole,
              decoration: const InputDecoration(label: Text("Role")),
            ),
            TextField(
              controller: widget._itemSalary,
              decoration: const InputDecoration(label: Text("Salary")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _employeeService.editItem(widget._itemName.text, {
                    "name": widget._itemName.text,
                    "role": widget._itemRole.text,
                    "salary": widget._itemSalary.text
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Edit Employee Success")));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "Employee Salary Database")));
                },
                child: const Text("Edit")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _employeeService.deleteItem(widget._itemName.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Delete Employee Success")));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "Employee Salary Database")));
                },
                child: const Text("Delete"))
          ],
        ),
      ),
    );
  }

  void _editItem() {
    _employeeService.editItem(widget._itemName.text, {
      "name": widget._itemName.text,
      "role": widget._itemRole.text,
      "salary": widget._itemSalary.text
    });
  }

  void _deleteItem() {
    _employeeService.deleteItem(widget._itemName.text);
  }
}
