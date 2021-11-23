import 'package:consultoria/app/domain/responses/sign_up_response.dart';
import 'package:consultoria/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:consultoria/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:consultoria/app/ui/pages/menu/menu_page.dart';
import 'package:flutter/material.dart';

import '../registros.dart' show registerProvider;
import 'package:flutter/cupertino.dart';

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    
    Navigator.pop(context); 
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "email already in use";
          break;
        case SignUpError.weakPassword:
          content = "weak password";
          break;

        case SignUpError.networkRequestFailed:
          content = "network Request Failed";
          break;
        case SignUpError.tooManyRequests:
          content = "too Many Requests";
          break;
        case SignUpError.unknown:
        default:
          content = "unknown error";
          break;
      }
      Dialogs.alert(
        context,
        title: "ERROR",
        content: content,
      );
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Menu(),
          ),
          (Route<dynamic> route) => false);
    }
  } else {
    Dialogs.alert(
      context,
      title: "ERROR",
      content: "Invalid fields",
    );
  }
}
