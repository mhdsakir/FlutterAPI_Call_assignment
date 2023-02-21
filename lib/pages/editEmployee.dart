import 'package:flutter/material.dart';
import 'package:mypos_assignment/base_client.dart';
import 'package:mypos_assignment/dataModels/employeeModel.dart';
import 'package:mypos_assignment/widgets/alert_dialog.dart';

class EditEmployee extends StatefulWidget {
  final Employee employee;

  EditEmployee({required this.employee});

  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _baseClient = BaseClient();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _noController;
  late TextEditingController _nameController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _address3Controller;
  late TextEditingController _departmentController;
  late TextEditingController _dobController;
  late TextEditingController _dojController;
  late TextEditingController _salaryController;
  late bool _isActive;

  @override
  void initState() {
    _noController = TextEditingController(text: widget.employee.empNo);
    _nameController = TextEditingController(text: widget.employee.empName);
    _address1Controller =
        TextEditingController(text: widget.employee.empAddressLine1);
    _address2Controller =
        TextEditingController(text: widget.employee.empAddressLine2);
    _address3Controller =
        TextEditingController(text: widget.employee.empAddressLine3);
    _departmentController =
        TextEditingController(text: widget.employee.departmentCode);
    _dobController = TextEditingController(text: widget.employee.dateOfBirth);
    _dojController = TextEditingController(text: widget.employee.dateOfJoin);
    _salaryController = TextEditingController(
        text: widget.employee.basicSalary.toStringAsFixed(2));
    _isActive = widget.employee.isActive;

    super.initState();
  }

  @override
  void dispose() {
    _noController.dispose();
    _nameController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _address3Controller.dispose();
    _departmentController.dispose();
    _dobController.dispose();
    _dojController.dispose();
    _salaryController.dispose();

    super.dispose();
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final updatedEmp = widget.employee.copyWith(
        empNo: _noController.text,
        empName: _nameController.text,
        empAddressLine1: _address1Controller.text,
        empAddressLine2: _address2Controller.text,
        empAddressLine3: _address3Controller.text,
        departmentCode: _departmentController.text,
        dateOfBirth: _dobController.text,
        dateOfJoin: _dojController.text,
        basicSalary: double.parse(_salaryController.text),
        isActive: _isActive,
      );

      try {
        MyAlertDialog.verificationDialog(
            context: context,
            title: 'Update Employee',
            content: 'Do you want to apply these changes?',
            tabNo: (() {
              Navigator.pop(context);
            }),
            tabYes: (() async {
              await _baseClient.updateEmployee(updatedEmp);
              MyAlertDialog.confirmationDialog(
                  context: context,
                  title: 'Done!',
                  content: 'Updated Successfully',
                  tabOk: (() {
                    Navigator.pushReplacementNamed(context, '/employeeList');
                  }));
            }));

        // show success message and navigate back to employee list
      } on Exception catch (e) {
        // show error message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Employee'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        )),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    maxLength: 15,
                    controller: _noController,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Employee Number'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter employee number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    maxLength: 50,
                    controller: _nameController,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Employee Name'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter employee name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    maxLength: 15,
                    controller: _departmentController,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Department Code'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Department Code';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _salaryController,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Bacic Salary'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter salary';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    maxLength: 80,
                    controller: _address1Controller,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Address Line1'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address Line1';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    maxLength: 80,
                    controller: _address2Controller,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Address Line2'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address Line2';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    maxLength: 80,
                    controller: _address3Controller,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Address Line3'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address Line3';
                      }
                      return null;
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _dobController,
                    decoration: inputDecoration.copyWith(
                      labelText: 'Date Of Birth',
                      icon: const Icon(Icons.calendar_month),
                    ),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        setState(() {
                          _dobController.text = pickedDate.toIso8601String();
                        });
                        print(_dobController.text);
                        _dobController.text = pickedDate.toIso8601String();
                      } else {}
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _dojController,
                    decoration: inputDecoration.copyWith(
                      labelText: 'Date Of Join',
                      icon: const Icon(Icons.calendar_month),
                    ),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        setState(() {
                          _dojController.text = pickedDate.toIso8601String();
                        });
                        print(_dojController.text);
                        _dojController.text = pickedDate.toIso8601String();
                      } else {}
                    },
                  ),
                ),
                CheckboxListTile(
                  title: const Text(
                    'Active',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value ?? false;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  child: Text('Save'.toUpperCase()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var inputDecoration = InputDecoration(
  labelText: '',
  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
  contentPadding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 1),
      borderRadius: BorderRadius.circular(15)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      borderRadius: BorderRadius.circular(15)),
);
