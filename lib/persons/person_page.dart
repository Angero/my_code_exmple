import 'package:example/persons/date_field.dart';
import 'package:example/persons/email_field.dart';
import 'package:example/persons/name_field.dart';
import 'package:example/persons/person_cubit.dart';
import 'package:example/persons/person_model.dart';
import 'package:example/persons/person_state.dart';
import 'package:example/persons/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonPage extends StatefulWidget {
  final PersonModel? personModel;

  const PersonPage({Key? key, this.personModel}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late PersonModel _personModel;
  late PersonCubit personCubit;
  bool _isValidSurname = true;
  bool _isValidName = true;
  bool _isValidFather = true;
  bool _isValidEmail = true;
  bool _isValidPhone = true;
  bool _isValidDate = true;

  void _submitForm() {
    if (_isValidSurname &&
        _isValidName &&
        _isValidFather &&
        _isValidEmail &&
        _isValidPhone &&
        _isValidDate) {
      if (_personModel.surname.isEmpty ||
          _personModel.name.isEmpty ||
          _personModel.phone.isEmpty ||
          _personModel.email.isEmpty) {
        personCubit.failure();
      } else {
        if (this.widget.personModel == null)
          personCubit.add(_personModel);
        else
          personCubit.save(_personModel);
        Navigator.of(context).pop();
      }
    } else
      personCubit.failure();
  }

  @override
  void initState() {
    super.initState();
    _personModel = this.widget.personModel ?? PersonModel.empty();
  }

  @override
  Widget build(BuildContext context) {
    personCubit = BlocProvider.of<PersonCubit>(context);
    return _scaffoldWidget();
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                if (this.widget.personModel == null) return;
                personCubit.delete(_personModel);
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [
        NameField(
            title: 'Surname',
            initial: _personModel.surname,
            valid: (check, value) {
              _isValidSurname = check;
              _personModel.surname = value;
            }),
        NameField(
            title: 'Name',
            initial: _personModel.name,
            valid: (check, value) {
              _isValidName = check;
              _personModel.name = value;
            }),
        NameField(
            title: 'Patronymic',
            initial: _personModel.father,
            valid: (check, value) {
              _isValidFather = check;
              _personModel.father = value;
            }),
        EmailField(
            initial: _personModel.email,
            valid: (check, value) {
              _isValidEmail = check;
              _personModel.email = value;
            }),
        PhoneField(
            initial: _personModel.phone,
            valid: (check, value) {
              _isValidPhone = check;
              _personModel.phone = value;
            }),
        DateField(
          valid: (check, value) {
            _isValidDate = check;
            _personModel.born = value;
          },
          initial: _personModel.born,
        ),
        NameField(
          title: 'Comment',
          initial: _personModel.comment,
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Save'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            PersonModel testModel = PersonModel.test();
            _personModel.surname = testModel.surname;
            _personModel.name = testModel.name;
            _personModel.father = testModel.father;
            _personModel.email = testModel.email;
            _personModel.phone = testModel.phone;
            _personModel.born = testModel.born;
            _personModel.comment = testModel.comment;
            _submitForm();
          },
          child: Text('Run test'),
        ),
        SizedBox(height: 16.0),
        _personCubitBuilder(context),
      ],
    );
  }

  Widget _personCubitBuilder(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      bloc: personCubit,
      builder: (BuildContext context, PersonState state) {
        if (state.status == PersonStatus.failure) {
          return Text(
            'Something wrong',
            style: TextStyle(color: Colors.red),
          );
        }
        return Container();
      },
    );
  }
}
