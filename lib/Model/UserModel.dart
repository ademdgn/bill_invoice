import 'BillModel.dart';

class Person {
  String name;
  String email;
  String password;
  String? photoUrl;

  Person({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}
