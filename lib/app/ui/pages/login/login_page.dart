import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/global_widgets/custom_login.dart';
import 'package:consultoria/app/ui/global_widgets/desing_custom.dart';
import 'package:consultoria/app/ui/pages/login/controller/login_controller.dart';
import 'package:consultoria/app/ui/pages/login/controller/utils/send_login_form.dart';
import 'package:consultoria/app/ui/pages/registro/registros.dart';
import 'package:consultoria/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:consultoria/app/utils/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, cont) {
        return Scaffold(
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const DesignCustom(),
                      Center(
                        //padding: const EdgeInsets.all(50 * 2),
                        child: Form(
                          key: cont.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ignore: prefer_const_constructors
                              SizedBox(
                                height: 70,
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 80.0,
                                child: Image(
                                  image:
                                      AssetImage('assets/img/logo1-modified.png'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //textField
                              CustomLogin(
                                label: 'Email',
                                onChanged: cont.onEmailChanged,
                                inputType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (isValidEmail(text!)) {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomLogin(
                                label: 'Contraseña',
                                isPassword: true,
                                onChanged: cont.onPasswordChanged,
                                validator: (text) {
                                  if (text!.trim().length >= 6) {
                                    return null;
                                  }
                                  return "Contraseña invalida";
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                                onPressed: () 
                                => sendLoginForm(context), 
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
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordPage(),
                                    ),
                                  ),
                                  child: const Text(
                                    "¿Olvidaste tu contraseña?",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "O deseas conectarte con: ",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Center(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xff38a4ef),
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                              ],
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xff38a4ef),
                            ),
                            height: 40,
                            width: 140,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFF7B5B5),
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                              ],
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            height: 40,
                            width: 140,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.email_outlined,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Gmail",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Registrate',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaginaRegistro(),
                          ),
                        ),
                      ),
                    ],
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
