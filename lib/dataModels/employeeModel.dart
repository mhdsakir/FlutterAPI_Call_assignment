// ignore_for_file: file_names

class Employee {
  String empNo;
  String empName;
  String empAddressLine1;
  String empAddressLine2;
  String empAddressLine3;
  String departmentCode;
  String dateOfBirth;
  String dateOfJoin;
  double basicSalary;
  bool isActive;

  Employee({
    required this.empNo,
    required this.empName,
    required this.empAddressLine1,
    required this.empAddressLine2,
    required this.empAddressLine3,
    required this.departmentCode,
    required this.dateOfBirth,
    required this.dateOfJoin,
    required this.basicSalary,
    required this.isActive,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empNo: json['empNo'],
      empName: json['empName'],
      empAddressLine1: json['empAddressLine1'],
      empAddressLine2: json['empAddressLine2'],
      empAddressLine3: json['empAddressLine3'],
      departmentCode: json['departmentCode'],
      dateOfBirth: json['dateOfBirth'], //DateTime.parse(json['dateOfBirth']),
      dateOfJoin: json['dateOfJoin'], //DateTime.parse(json['dateOfJoin']),
      basicSalary: json['basicSalary'].toDouble(),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empNo'] = this.empNo;
    data['empName'] = this.empName;
    data['empAddressLine1'] = this.empAddressLine1;
    data['empAddressLine2'] = this.empAddressLine2;
    data['empAddressLine3'] = this.empAddressLine3;
    data['departmentCode'] = this.departmentCode;
    data['dateOfBirth'] = this.dateOfBirth;
    data['dateOfJoin'] = this.dateOfJoin;
    data['basicSalary'] = this.basicSalary;
    data['isActive'] = this.isActive;
    return data;
  }

  copyWith(
      {String? empNo,
      String? empName,
      String? empAddressLine1,
      String? empAddressLine2,
      String? empAddressLine3,
      String? departmentCode,
      String? dateOfBirth,
      String? dateOfJoin,
      double? basicSalary,
      bool? isActive}) {
        return Employee(
      empNo: empNo ?? this.empNo,
      empName: empName ?? this.empName,
      empAddressLine1: empAddressLine1 ?? this.empAddressLine1,
      empAddressLine2: empAddressLine2 ?? this.empAddressLine2,
      empAddressLine3: empAddressLine3 ?? this.empAddressLine3,
      departmentCode: departmentCode ?? this.departmentCode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfJoin: dateOfJoin ?? this.dateOfJoin,
      basicSalary: basicSalary ?? this.basicSalary,
      isActive: isActive ?? this.isActive,
    );
      }
}
