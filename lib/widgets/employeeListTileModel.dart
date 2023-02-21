import 'package:flutter/material.dart';
import 'package:mypos_assignment/base_client.dart';
import 'package:mypos_assignment/dataModels/employeeModel.dart';
import 'package:mypos_assignment/pages/editEmployee.dart';
import 'package:mypos_assignment/widgets/alert_dialog.dart';

class empListTileModel extends StatelessWidget {
  const empListTileModel({
    Key? key,
    required List<Employee> employees,
    required BaseClient baseClient,
  })  : _employees = employees,
        _baseClient = baseClient,
        super(key: key);

  final List<Employee> _employees;
  final BaseClient _baseClient;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _employees.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey, width: 2),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Employee No: ${_employees[index].empNo}',
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
                                            builder: (context) => EditEmployee(
                                                employee: _employees[index])));
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
                                              _employees[index].empNo);
                                          Navigator.pop(context);
                                          MyAlertDialog.confirmationDialog(
                                              context: context,
                                              title: 'Done!',
                                              content: 'Deleted Successfully',
                                              tabOk: (() {
                                                Navigator.pushReplacementNamed(
                                                    context, '/employeeList');
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
                          'Name: ${_employees[index].empName}',
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 48, 36, 36),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              /* subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('See Delails...'),
                  ],
                ), */
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.yellow,
                Colors.green,
                
              ],
            ),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ('AddressLine1: ${_employees[index].empAddressLine1}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('AddressLine2: ${_employees[index].empAddressLine2}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('AddressLine3: ${_employees[index].empAddressLine3}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('DepartmentCode: ${_employees[index].departmentCode}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('BaseSalary: ${_employees[index].basicSalary}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('DateOfBirth: ${_employees[index].dateOfBirth}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('DateOfJoin: ${_employees[index].dateOfJoin}'),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          _employees[index].isActive == true
                              ? const Text(
                                  ('Status: Active'),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  ('Status: Not Active'),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
