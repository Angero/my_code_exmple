import 'package:equatable/equatable.dart';
import 'package:example/persons/person_model.dart';

enum PersonStatus { initial, waiting, success, failure }

class PersonState extends Equatable {
  const PersonState({
    this.status = PersonStatus.initial,
    this.persons = const <PersonModel>[],
  });

  final PersonStatus status;
  final List<PersonModel> persons;

  PersonState copyWith({
    PersonStatus? status,
    List<PersonModel>? persons,
    bool? hasError,
  }) {
    return PersonState(
      status: status ?? this.status,
      persons: persons ?? this.persons,
    );
  }

  @override
  String toString() {
    return '''PersonState { status: $status, posts: ${persons.length} }''';
  }

  @override
  List<Object> get props => [status, persons];
}
