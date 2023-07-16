import 'package:example/persons/person_model.dart';
import 'package:example/persons/person_repository.dart';
import 'package:example/persons/person_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonCubit extends Cubit<PersonState> {
  final PersonRepository personRepository;

  PersonCubit(this.personRepository) : super(const PersonState());

  void fetch() async {
    emit(state.copyWith(status: PersonStatus.waiting));

    try {
      final list = await personRepository.fetch();
      emit(state.copyWith(status: PersonStatus.success, persons: list));
    } catch (e) {
      print('RA: ${e.toString()}');
      emit(state.copyWith(status: PersonStatus.failure));
    }
  }

  void add(PersonModel personModel) async {
    personRepository.add(personModel);
    fetch();
  }

  void save(PersonModel personModel) async {
    personRepository.save(personModel);
    fetch();
  }

  void delete(PersonModel personModel) async {
    personRepository.delete(personModel);
    fetch();
  }

  void failure() {
    emit(state.copyWith(status: PersonStatus.failure));
  }
}
