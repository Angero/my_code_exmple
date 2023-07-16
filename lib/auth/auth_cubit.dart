import 'package:example/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { initial, waiting, signedIn, signedOut, failure }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthState.initial);

  void signIn({required String email, required String password}) async {
    emit(AuthState.waiting);

    try {
      bool access = await authRepository.signIn(email: email, password: password);
      if (access)
        emit(AuthState.signedIn);
      else
        emit(AuthState.failure);
    } catch (e) {
      print('RA: ${e.toString()}');
      emit(AuthState.failure);
    }
  }

  void signOut() {
    emit(AuthState.waiting);

    try {
      authRepository.signOut();
      emit(AuthState.signedOut);
    } catch (e) {
      print('RA: ${e.toString()}');
      emit(AuthState.failure);
    }
  }
}
