import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mypos_assignment/base_client.dart';
import 'package:mypos_assignment/dataModels/employeeModel.dart';
import 'package:mypos_assignment/widgets/alert_dialog.dart';
import 'package:mypos_assignment/widgets/sideBar.dart';
import 'package:hexcolor/hexcolor.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  //these controllers for datepicker...
  TextEditingController _dobController = TextEditingController();
  TextEditingController _dojController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _apiClient = BaseClient();
  late final Employee _employee = Employee(
    empNo: '',
    empName: '',
    departmentCode: '',
    basicSalary: 0,
    dateOfBirth: DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()),
    dateOfJoin: DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()),
    empAddressLine1: '',
    empAddressLine2: '',
    empAddressLine3: '',
    isActive: true,
  );

  get a => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      maxLength: 15,
                      decoration: inputDecoration.copyWith(
                          labelText: 'Employee Number'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => _employee.empNo = value!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      maxLength: 50,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Employee Name'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => _employee.empName = value!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      maxLength:15 ,
                      decoration: inputDecoration.copyWith(
                          labelText: 'Department Code'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a department code';
                        }
                        return null;
                      },
                      onSaved: (value) => _employee.departmentCode = value!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                      decoration:
                          inputDecoration.copyWith(labelText: 'Basic Salary'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a salary';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          _employee.basicSalary = double.parse(value!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      maxLength: 80,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Address Line1'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address line1';
                        }
                        return null;
                      },
                      onSaved: (value) => _employee.empAddressLine1 = value!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      maxLength: 80,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Address Line2'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address line2';
                        }
                        return null;
                      },
                      onSaved: (value) => _employee.empAddressLine2 = value!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      maxLength: 80,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Address Line3'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address line3';
                        }
                        return null;
                      },
                      onSaved: (value) => _employee.empAddressLine3 = value!,
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
                            _employee.dateOfBirth =
                                pickedDate.toIso8601String();
                          });
                          print(_employee.dateOfBirth);
                          _dobController.text = pickedDate.toIso8601String();
                        } else {}
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextField(
                      controller: _dojController,
                      decoration: inputDecoration.copyWith(
                        labelText: 'Date Of Join',
                        icon: const Icon(Icons.calendar_month),
                      ),
                      readOnly: true,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          setState(() {
                            _employee.dateOfJoin = pickedDate.toIso8601String();
                          });
                          print(_employee.dateOfJoin);
                          _dojController.text = pickedDate.toIso8601String();
                        } else {}
                      },
                    ),
                  ),

                  ElevatedButton(
                    onPressed: _submitDetails,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text('Add Employee'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  void _submitDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Send a request to the API to add the new employee
      MyAlertDialog.verificationDialog(
          context: context,
          title: 'Add Employee',
          content: 'Are you sure to add this employee?',
          tabNo: () {
            Navigator.pop(context);
          },
          tabYes: () {
            _apiClient
                .addEmployee(_employee)
                .then((value) => _formKey.currentState!.reset());
            Navigator.pop(context);
            MyAlertDialog.confirmationDialog(
                context: context,
                title: 'Done!',
                content: 'Added Successfully',
                tabOk: (() {
                  Navigator.pushReplacementNamed(context, '/addEmployee');
                }));
          });
    }
  }
}
