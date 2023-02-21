import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypos_assignment/base_client.dart';
import 'package:mypos_assignment/dataModels/employeeModel.dart';
import 'package:mypos_assignment/pages/editEmployee.dart';
import 'package:mypos_assignment/widgets/alert_dialog.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _empNoController = TextEditingController();
  String searchInput = '';
  final BaseClient _baseClient = BaseClient();
  Employee? _employee;

  void _searchEmployee() async {
    try {
      Employee employee = await _baseClient.searchEmployeeByEmpNo(searchInput);
      setState(() {
        _employee = employee;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/employeeList');
          },
        ),
        actions: [
          IconButton(
            onPressed: () => _searchEmployee(),
            icon: const Icon(Icons.search),
          ),
        ],
        title: CupertinoSearchTextField(
          controller: _empNoController,
          autofocus: true,
          backgroundColor: Colors.white,
          onChanged: ((value) {
            setState(() {
              searchInput = value;
            });
          }),
        ),
      ),
      body: searchInput == ''
          ? Container(
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
              child: const Center(
                  child: Text(
                'Search by Employee Number...',
                style: TextStyle(color: Colors.black),
              )),
            )
          : _employee != null
              ? Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 50),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Employee No: ${_employee!.empNo}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditEmployee(
                                                              employee:
                                                                  _employee!)));
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.purple,
                                            )),
                                        IconButton(
                                            onPressed: () async {
                                              MyAlertDialog.verificationDialog(
                                                  context: context,
                                                  title: 'Delete Employee',
                                                  content:
                                                      'Are you sure to delete this employee?',
                                                  tabNo: () {
                                                    Navigator.pop(context);
                                                  },
                                                  tabYes: () {
                                                    _baseClient.deleteEmployee(
                                                        _employee!.empNo);
                                                    Navigator.pop(context);
                                                    MyAlertDialog
                                                        .confirmationDialog(
                                                            context: context,
                                                            title: 'Done!',
                                                            content:
                                                                'Deleted Successfully',
                                                            tabOk: (() {
                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      '/employeeList');
                                                            }));
                                                  });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.brown,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Name: ${_employee!.empName}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 182, 16, 162),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ('AddressLine1: ${_employee!.empAddressLine1}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      ('AddressLine2: ${_employee!.empAddressLine2}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      ('AddressLine3: ${_employee!.empAddressLine3}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      ('DepartmentCode: ${_employee!.departmentCode}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      ('BaseSalary: ${_employee!.basicSalary}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      ('DateOfBirth: ${_employee!.dateOfBirth}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      ('DateOfJoin: ${_employee!.dateOfJoin}'),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    _employee!.isActive == true
                                        ? const Text(
                                            ('Status: Active'),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )
                                        : const Text(
                                            ('Status: Not Active'),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'No Employee found',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
    );
  }
}
