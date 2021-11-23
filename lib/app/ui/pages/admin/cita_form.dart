import 'package:consultoria/app/ui/global_widgets/custom_login.dart';
import 'package:consultoria/app/ui/global_widgets/custom_widget.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_service.dart';
import 'package:consultoria/app/utils/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class CitaForm extends StatefulWidget {
  final DateTime day;
  CitaForm({Key? key, required this.day}) : super(key: key);

  @override
  State<CitaForm> createState() => _CitaFormState();
}

class _CitaFormState extends State<CitaForm> {
  var _formKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();

  var _citaService = CitaService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 400,
          child: ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFede7f6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email'
                  ),
                  controller: _emailController,
                  validator: (text) {
                    return isValidEmail(text!) ? null : 'Email invalido';
                  },
                ),
              ),
            ),
            trailing: IconButton(
                icon: const Icon(Icons.send, color:  Color(0xFFede7f6),),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _citaService.create(
                        _emailController.text, widget.day);
                    _emailController.clear();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
