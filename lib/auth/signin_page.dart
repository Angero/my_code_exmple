import 'package:example/auth/auth_cubit.dart';
import 'package:example/persons/persons_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isValidEmail = true;
  bool _isValidPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail(String email) {
    // Basic email validation pattern
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    RegExp regExp = RegExp(pattern);

    setState(() {
      _isValidEmail = regExp.hasMatch(email);
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isValidPassword = password.length >= 6;
    });
  }

  void _submitForm() {
    if (_isValidEmail && _isValidPassword) {
      String email = _emailController.text;
      String password = _passwordController.text;

      print('Email: $email');
      print('Password: $password');

      final authCubit = BlocProvider.of<AuthCubit>(context);
      authCubit.signIn(email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget();
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: _isValidEmail ? null : 'Invalid email',
          ),
          onChanged: (value) {
            _validateEmail(value);
          },
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: _isValidPassword
                ? null
                : 'Password should be at least 6 characters',
          ),
          onChanged: (value) {
            _validatePassword(value);
          },
        ),
        SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Sign In'),
        ),
        SizedBox(height: 32.0),
        _authCubitConsumer(context),
        SizedBox(height: 32.0),
        _infoWidget(),
      ],
    );
  }

  Widget _authCubitConsumer(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: BlocProvider.of<AuthCubit>(context),
      listener: (BuildContext context, AuthState state) {
        if (state == AuthState.signedIn) {
          Navigator.of(context).pop();
        }
      },
      builder: (BuildContext context, AuthState state) {
        if (state == AuthState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state == AuthState.failure) {
          return Center(
            child: Text(
              'Sign in error',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _infoWidget() {
    return Column(
      children: [
        Text(
          'Test credentials:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('user1@test.com - secret1'),
        Text('user2@test.com - secret2'),
        SizedBox(height: 16.0),
        ElevatedButton(
          child: Text('Fill in for user 1'),
          onPressed: () {
            _emailController.text = 'user1@test.com';
            _passwordController.text = 'secret1';
          },
        ),
      ],
    );
  }
}
