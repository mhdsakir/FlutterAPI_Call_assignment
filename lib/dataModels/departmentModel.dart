class Department {
  final String id;
  final String name;
  final bool isActive;

  Department({required this.id, required this.name, required this.isActive});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
        id: json['departmentCode'],
        name: json['departmentName'],
        isActive: json['isActive']);
  }
}