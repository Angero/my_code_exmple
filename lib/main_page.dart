import 'package:example/auth/auth_cubit.dart';
import 'package:example/auth/signin_page.dart';
import 'package:example/persons/persons_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget(context);
  }

  Widget _scaffoldWidget(BuildContext context) {
    return Scaffold(
      body: _authCubitConsumer(context),
    );
  }

  Widget _authCubitConsumer(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: BlocProvider.of<AuthCubit>(context)..signOut(),
      listener: (BuildContext context, AuthState state) {
        if (state == AuthState.initial) {}
      },
      builder: (BuildContext context, AuthState state) {
        if (state == AuthState.signedIn) {
          return _whenSignedInWidget(context);
        } else if (state == AuthState.signedOut) {
          return _whenSignedOutWidget(context);
        } else if (state == AuthState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state == AuthState.failure) {
          return Center(
            child: Text('Some Error'),
          );
        }
        return Container();
      },
    );
  }

  Widget _whenSignedInWidget(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          _titleWidget(),
          ElevatedButton(
            child: Text('Persons'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PersonsPage();
                  },
                ),
              );
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text('Sign out'),
            onPressed: () {
              BlocProvider.of<AuthCubit>(context)..signOut();
            },
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _whenSignedOutWidget(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          _titleWidget(),
          ElevatedButton(
            child: Text('Sign in'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SigninPage();
                  },
                ),
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Text(
        'My Code Example',
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,),
        textAlign: TextAlign.center,
      ),
    );
  }
}
