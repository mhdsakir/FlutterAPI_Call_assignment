import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mypos_assignment/dataModels/employeeModel.dart';


//I directly include api to the relevent pages, bcs it occurs some problem to call from here...

class BaseClient {
  var client = http.Client();
  final String baseUrl = 'http://examination.24x7retail.com';
  final String apiKey = '?D(G+KbPeSgVkYp3s6v9y\$B&E)H@McQf';

  final _headers = {
    'Content-Type': 'application/json',
    'apiToken': '?D(G+KbPeSgVkYp3s6v9y\$B&E)H@McQf',
  };

  Future<void> addEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1.0/Employee'),
      headers: _headers,
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode != 200) {
      return null;
    } else {
      print('success');
    }
  }
  

  Future<void> updateEmployee(Employee employee) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/v1.0/Employee'),
      headers: _headers,
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update employee.');
    } else {
      print("success");
      print(jsonEncode(employee
          .toJson()));
    }
  }

  Future<void> deleteEmployee(String empNo) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/v1.0/Employee/$empNo'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee.');
      print(response.reasonPhrase);
    } else {
      print("success");
    }
  }

  Future<Employee> searchEmployeeByEmpNo(String empNo) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1.0/Employee/$empNo'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load employee');
    } else {
      final jsonData = jsonDecode(response.body);
      final employee = Employee.fromJson(jsonData);
      return employee;
      print("employee");
    }
  }
}
