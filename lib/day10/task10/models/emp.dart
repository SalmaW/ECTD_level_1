class Employee {
  final int? id;
  String name;
  String email;
  String pass;
  String phone;
  String confirmPass;

  Employee(
      {this.id,
      required this.name,
      required this.email,
      required this.pass,
      required this.phone,
      required this.confirmPass});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        email: json['email'],
        pass: json['pass'],
        phone: json['phone'],
        confirmPass: json['confirmPass'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'pass': pass,
        'phone': phone,
        'confirmPass': confirmPass,
      };
}
