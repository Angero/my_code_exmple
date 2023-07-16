import 'package:example/persons/person_model.dart';

class PersonStore {
  PersonStore._();

  static final instance = PersonStore._();

  List<PersonModel> list = [];
}
