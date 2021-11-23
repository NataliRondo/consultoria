
import 'package:consultoria/app/ui/pages/registro/registros.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column( 
            children: [
              ElevatedButton(
                
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaginaRegistro(),
                  ),
                ),
                child: const Text('Sing Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
