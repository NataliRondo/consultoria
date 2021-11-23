

import 'package:consultoria/app/domain/inputs/sign_up.dart';
import 'package:consultoria/app/domain/repositories/sign_up_repository.dart';
import 'package:consultoria/app/domain/responses/sign_up_response.dart';
import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/registro/controller/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class RegisterController extends StateNotifier<RegisterState>{
  final SessionController _sessionController;
  RegisterController(this._sessionController) : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();
  
  final SignUpRepository _signUpRepository = Get.i.find();

  Future<SignUpResponse> submit() async{
    final response = await _signUpRepository.register(
      SignUpData(
        nombre: state.nombre,
        apellido: state.apellido,
        email: state.email,
        password: state.password,
        telefono: state.telefono
      ),
    );
    if(response.error == null){
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(nombre: text);
  }

  void onLastNameChanged(String text) {
    state = state.copyWith(apellido: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vpassword: text);
  }
  void onTelephoneChanged(String text) {
    state = state.copyWith(telefono: text);
  }
  
}