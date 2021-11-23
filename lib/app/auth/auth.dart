
import 'package:consultoria/app/modulos/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> singInEmailPassword(String email, String password);
  Future<String> singUnEmailPassword(Usuario usuario);
  Future<void> singOut();
  Future<String> currentUser();
  //FirebaseUser se cambio a User
  //la clase AuthResult se cambio a UserCredential
  Future<FirebaseAuth> infoUser();
}

