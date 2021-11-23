import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState(
      {
      @Default('') String email,
      @Default('') String password,
      @Default('') String vpassword,
      @Default('') String nombre,
      @Default('') String apellido,
      @Default('') String telefono,
      @Default(false) bool terminosOk}) = _RegisterState;

  static RegisterState get initialState => RegisterState();
}
