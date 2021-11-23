import 'package:consultoria/app/domain/inputs/sign_up.dart';
import 'package:consultoria/app/domain/repositories/sign_up_repository.dart';
import 'package:consultoria/app/domain/responses/sign_up_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;
  SignUpRepositoryImpl(this._auth);

  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      await userCredential.user!.updateDisplayName(
        "${data.nombre} ${data.apellido}",
      );
      return SignUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(
        parseStringToSignUpError(e.code),
        null,
      );
    }
  }
}