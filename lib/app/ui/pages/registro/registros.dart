import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/global_widgets/custom_widget.dart';
import 'package:consultoria/app/ui/global_widgets/desing_custom.dart';
import 'package:consultoria/app/ui/pages/registro/controller/register_controller.dart';
import 'package:consultoria/app/ui/pages/registro/controller/register_state.dart';
import 'package:consultoria/app/ui/pages/registro/utils/send_register_form.dart';
import 'package:consultoria/app/utils/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:flutter_meedu/meedu.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class PaginaRegistro extends StatelessWidget {
  const PaginaRegistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Registro'),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Stack(
                children: [
                  const DesignCustom(),
                  Form(
                    key: controller.formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomField(
                              label: "Nombres",
                              onChanged: controller.onNameChanged,
                              validator: (text) {
                                if (isValidEmail(text!)) {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomField(
                              label: "Apellidos",
                              onChanged: controller.onLastNameChanged,
                              validator: (text) {
                                if (isValidEmail(text!)) {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomField(
                              label: "Email",
                              inputType: TextInputType.emailAddress,
                              onChanged: controller.onEmailChanged,
                              validator: (text) {
                                return isValidEmail(text!)
                                    ? null
                                    : 'Email invalido';
                              },
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomField(
                              label: "Contraseña",
                              isPassword: true,
                              onChanged: controller.onPasswordChanged,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return "Contraseña invalida";
                              },
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Consumer(builder: (_, ref, __) {
                              final controller = ref.watch(
                                  registerProvider.select((_) => _.password));
                              return CustomField(
                                label: 'Verifica tu contraseña',
                                isPassword: true,
                                onChanged: controller.onVPasswordChanged,
                                validator: (text) {
                                  if (controller.state.password != text) {
                                    return 'Las contraseñas no coinciden';
                                  }
                                  if (text!.trim().length >= 6) {
                                    return null;
                                  }
                                  return "Contraseña invalida";
                                },
                              );
                            }),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomField(
                              label: "Telefono",
                              inputType: TextInputType.phone,
                              onChanged: controller.onTelephoneChanged,
                              validator: (text) {
                                if (text == null)
                                  // ignore: curly_braces_in_flow_control_structures
                                  return "Telefono invalido";
                                if (text.trim().length <= 12) {
                                  return null;
                                }
                                return "Telefono invalido";
                              },
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CupertinoButton(
                              child: const Text("REGISTRAR"),
                              color: Colors.deepPurple[100],
                              onPressed: () => sendRegisterForm(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
