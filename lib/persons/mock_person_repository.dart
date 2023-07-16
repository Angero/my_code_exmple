import 'package:example/persons/person_model.dart';
import 'package:example/persons/person_repository.dart';
import 'package:example/persons/person_store.dart';

class MockPersonRepository implements PersonRepository {
  @override
  void add(PersonModel) {
    PersonStore.instance.list.add(PersonModel);
  }

  @override
  Future<List<PersonModel>> fetch() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return PersonStore.instance.list;
  }

  @override
  void save(PersonModel personModel) async {
    await Future.delayed(Duration(milliseconds: 1000));
    PersonModel? _personModel = find(personModel.id);
    if (_personModel == null) return;
    _personModel.surname = personModel.surname;
    _personModel.name = personModel.name;
    _personModel.father = personModel.father;
    _personModel.email = personModel.email;
    _personModel.phone = personModel.phone;
    _personModel.born = personModel.born;
    _personModel.comment = personModel.comment;
  }

  @override
  void delete(PersonModel personModel) async {
    await Future.delayed(Duration(milliseconds: 1000));
    PersonModel? _personModel = find(personModel.id);
    if (_personModel == null) return;
    PersonStore.instance.list.remove(_personModel);
  }

  PersonModel? find(String id) {
    for (var model in PersonStore.instance.list) {
      if (model.id == id) {
        return model;
      }
    }
    return null;
  }
}
