import 'package:example/auth/auth_cubit.dart';
import 'package:example/auth/mock_auth_repository.dart';
import 'package:example/main_page.dart';
import 'package:example/persons/mock_person_repository.dart';
import 'package:example/persons/person_cubit.dart';
import 'package:example/persons/person_model.dart';
import 'package:example/persons/person_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _multiBlocProvider();
  }

  Widget _multiBlocProvider() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(MockAuthRepository()),
        ),
        BlocProvider<PersonCubit>(
          create: (BuildContext context) => PersonCubit(MockPersonRepository()),
        ),
      ],
      child: _materialApp(),
    );
  }

  Widget _materialApp() {
    return MaterialApp(
      title: 'Example App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MainPage(),
    );
  }
}
