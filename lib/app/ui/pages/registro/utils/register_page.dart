
import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/global_widgets/custom_widget.dart';
import 'package:consultoria/app/ui/pages/registro/controller/register_controller.dart';
import 'package:consultoria/app/ui/pages/registro/controller/register_state.dart';
import 'package:consultoria/app/ui/pages/registro/utils/send_register_form.dart';
import 'package:consultoria/app/utils/email_validator.dart';
import 'package:consultoria/app/utils/name_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Form(
                key: controller.formKey,
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    CustomField(
                      label: "Name",
                      onChanged: controller.onNameChanged,
                      validator: (text) {
                        return isValidName(text!) ? null : "invalid name";
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      label: "Last Name",
                      onChanged: controller.onLastNameChanged,
                      validator: (text) {
                        return isValidName(text!) ? null : "invalid last name";
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      label: "E-mail",
                      inputType: TextInputType.emailAddress,
                      onChanged: controller.onEmailChanged,
                      validator: (text) {
                        return isValidEmail(text!) ? null : "invalid email";
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      label: "Password",
                      onChanged: controller.onPasswordChanged,
                      isPassword: true,
                      validator: (text) {
                        if (text!.trim().length >= 6) {
                          return null;
                        }
                        return "invalid password";
                      },
                    ),
                    const SizedBox(height: 15),
                    Consumer(
                      builder: (_, ref, __) {
                        final controller = ref
                            .watch(registerProvider.select((_) => _.password));
                        return CustomField(
                          label: "Verification Password",
                          onChanged: controller.onVPasswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (controller.state.password != text) {
                              return "password don't match";
                            }
                            if (text!.trim().length >= 6) {
                              return null;
                            }
                            return "invalid password";
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text("REGISTER"),
                      onPressed: () => sendRegisterForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
