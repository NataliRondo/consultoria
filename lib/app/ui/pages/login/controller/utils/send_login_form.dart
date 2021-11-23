
import 'package:consultoria/app/domain/responses/sign_in_response.dart';
import 'package:consultoria/app/ui/pages/login/login_page.dart' show loginProvider;
import 'package:consultoria/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:consultoria/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;


Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      String errorMessage = "";

      switch (response.error) {
        case SignInError.networkRequestFailed:
          errorMessage = "network Request Failed";
          break;
        case SignInError.userDisabled:
          errorMessage = "user Disabled";
          break;
        case SignInError.userNotFound:
          errorMessage = "user Not Found";
          break;
        case SignInError.wrongPassword:
          errorMessage = "wrong Password";
          break;
        case SignInError.tooManyRequests:
          errorMessage = "too Many Requests";
          break;
        case SignInError.unknown:
        default:
          errorMessage = "unknown error";
          break;
      }

      Dialogs.alert(
        context,
        title: "ERROR",
        content: errorMessage,
      );
    } else {
      router.pushReplacementNamed(
        Routes.MENU,
      );
    }
  }
}