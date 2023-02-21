import 'package:flutter/material.dart';
import 'package:mypos_assignment/pages/departmentList.dart';
import 'package:mypos_assignment/pages/employeeList.dart';
import 'package:mypos_assignment/pages/addEmployee.dart';
import 'package:mypos_assignment/pages/searchScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:'/addEmployee',
      routes: {
        '/addEmployee':(context) => const AddEmployeeScreen(),
        '/departmentList':(context) => DepartmentListScreen(),
        '/employeeList':(context) => EmployeeListScreen(),
        '/search':(context) => const SearchScreen(),
      },
    );
  }
}


