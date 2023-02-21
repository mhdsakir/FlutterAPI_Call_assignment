// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mypos_assignment/base_client.dart';
import 'package:mypos_assignment/widgets/employeeListTileModel.dart';

import 'dart:convert';

import 'package:mypos_assignment/dataModels/employeeModel.dart';
import 'package:mypos_assignment/widgets/sideBar.dart';
import 'package:mypos_assignment/pages/editEmployee.dart';
import 'package:mypos_assignment/widgets/alert_dialog.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> _employees = [];
  bool _isLoading = false;
  final BaseClient _baseClient = BaseClient();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  void _fetchEmployees() async {
    setState(() {
      _isLoading = true;
    });
    //
    final response = await http.get(
        Uri.parse('http://examination.24x7retail.com/api/v1.0/Employees'),
        headers: {
          'Content-Type': 'application/json',
          'apiToken': '?D(G+KbPeSgVkYp3s6v9y\$B&E)H@McQf',
        });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _employees = List<Employee>.from(
            jsonData.map((employee) => Employee.fromJson(employee)));
        _isLoading = false;
      });
    } else {
      print(response.statusCode);
      print('Error fetching Employees');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: (() {
                  Navigator.pushReplacementNamed(context, '/search');
                }),
                icon: const Icon(Icons.search)),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
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
                child: const SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            )
          : Container(
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
              child: empListTileModel(
                  employees: _employees, baseClient: _baseClient)),
    );
  }
}
