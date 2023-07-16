import 'package:example/persons/person_model.dart';

abstract class PersonRepository {
  Future<List<PersonModel>> fetch();

  void add(PersonModel personModel);

  void save(PersonModel personModel);

  void delete(PersonModel personModel);
}
