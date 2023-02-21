import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:convert';

import 'package:mypos_assignment/dataModels/departmentModel.dart';
import 'package:mypos_assignment/widgets/sideBar.dart';

class DepartmentListScreen extends StatefulWidget {
  @override
  _DepartmentListScreenState createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen> {
  List<Department> _departments = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
  }

  void _fetchDepartments() async {
    setState(() {
      _isLoading = true;
    });
    //
    final response = await http.get(
        Uri.parse('http://examination.24x7retail.com/api/v1.0/Departments'),
        headers: {
          'Content-Type': 'application/json',
          'apiToken': '?D(G+KbPeSgVkYp3s6v9y\$B&E)H@McQf',
        });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _departments = List<Department>.from(
            jsonData.map((department) => Department.fromJson(department)));
        _isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);
      print('Error fetching departments');
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
        title: Text('Departments'),
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
                child: SpinKitCircle(
                  color: Color.fromARGB(255, 219, 11, 132),
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
              child: ListView.builder(
                itemCount: _departments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                      Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Department Code: ${_departments[index].id}',style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('Department Name: ${_departments[index].name}',style: const TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),),

                            _departments[index].isActive == true?
                            const Text('Status: Active',style: TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),):
                            const Text('Status: Not Active',style: TextStyle(
                                fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),

                    ),
                  );
                },
              ),
            ),
    );
  }
}
