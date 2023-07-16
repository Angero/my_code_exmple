import 'package:example/persons/person_cubit.dart';
import 'package:example/persons/person_model.dart';
import 'package:example/persons/person_page.dart';
import 'package:example/persons/person_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsPage extends StatelessWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget(context);
  }

  Widget _scaffoldWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PersonPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _personCubitBuilder(context),
    );
  }

  Widget _personCubitBuilder(BuildContext context) {
    final personCubit = BlocProvider.of<PersonCubit>(context);
    return BlocBuilder<PersonCubit, PersonState>(
      bloc: personCubit,
      builder: (BuildContext context, PersonState state) {
        if (state.status == PersonStatus.initial) {
        } else if (state.status == PersonStatus.waiting) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state.status == PersonStatus.success) {
          return _listWidget(context, state.persons);
        } else if (state.status == PersonStatus.failure) {
          return Center(
            child: Text(
              'Something wrong',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _listWidget(BuildContext context, List<PersonModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: _cardWidget(context, list[index]),
        );
      },
    );
  }

  Widget _cardWidget(BuildContext context, PersonModel personModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PersonPage(personModel: personModel);
            },
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(personModel.surname),
              Text(personModel.name),
              Text(personModel.father),
              Text(personModel.email),
              Text(personModel.phone),
            ],
          ),
        ),
      ),
    );
  }
}
