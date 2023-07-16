import 'package:uuid/uuid.dart';

class PersonModel {
  String id;
  String surname;
  String name;
  String father;
  String email;
  String phone;
  int born;
  String comment;

  PersonModel(
      {required this.id,
      required this.surname,
      required this.name,
      required this.father,
      required this.email,
      required this.phone,
      required this.born,
      required this.comment});

  factory PersonModel.empty() {
    return PersonModel(
      id: Uuid().v4(),
      surname: '',
      name: '',
      father: '',
      email: '',
      phone: '',
      born: DateTime.now().millisecondsSinceEpoch,
      comment: '',
    );
  }

  factory PersonModel.test() {
    return PersonModel(
      id: Uuid().v4(),
      surname: 'Smith',
      name: 'Antony',
      father: 'Jammy',
      email: 'user1@test.com',
      phone: '+7 (922) 322-22444',
      born: DateTime(1990, 4, 17).millisecondsSinceEpoch,
      comment: 'Developer',
    );
  }
}
