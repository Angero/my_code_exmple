import 'package:example/auth/auth_repository.dart';
import 'package:example/auth/auth_store.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<bool> signIn({required String email, required String password}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (email == AuthStore.email1 && password == AuthStore.password1)
      return true;
    if (email == AuthStore.email2 && password == AuthStore.password2)
      return true;
    return false;
  }

  @override
  void signOut() {
    // TODO: implement signOut
  }
}
