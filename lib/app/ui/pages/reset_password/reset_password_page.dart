import 'package:consultoria/app/domain/responses/reset_password_response.dart';
import 'package:consultoria/app/ui/global_widgets/custom_widget.dart';
import 'package:consultoria/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:consultoria/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:consultoria/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:consultoria/app/utils/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final resetPasswordProvider = SimpleProvider((_) => ResetPasswordController());

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent.shade100,
          title: const Text('Cambiar contraseña'),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                children: [
                  CustomField(
                    label: "Email",
                    onChanged: controller.onEmailChanged,
                    inputType: TextInputType.emailAddress,
                  ),
                  FlatButton(
                    onPressed: () => _submit(context),
                    //=> Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Menu()),(Route<dynamic> route) => false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 35),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfffce4ec),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 40,
                        width: 150,
                        child: const Center(
                          child: Text(
                            "Enviar",
                            style: TextStyle(
                              color: Colors.black87,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.sumbit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(
          context,
          title: "GOOD",
          content: "Email enviado",
        );
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "network Request Failed";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "user Disabled";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "user Not Found";
            break;
          case ResetPasswordResponse.tooManyRequests:
            errorMessage = "too Many Requests";
            break;
          case ResetPasswordResponse.unknown:
          default:
            errorMessage = "unknown error";
            break;
        }
        Dialogs.alert(
          context,
          title: "ERROR",
          content: errorMessage,
        );
      }
    } else {
      Dialogs.alert(context, content: "Invalid email");
    }
  }
}
