// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLogin extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomLogin({
    Key? key,
    this.onChanged,
    required this.label,
    this.inputType,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  _CustomLoginState createState() => _CustomLoginState();
}

class _CustomLoginState extends State<CustomLogin> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        initialValue: '',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: TextField(
                    obscureText: _obscureText,
                    keyboardType: widget.inputType,
                    onChanged: (text) {
                      if (widget.onChanged != null) {
                        state.setValue(text);
                        state.validate();
                      }
                      if (widget.onChanged != null) {
                        widget.onChanged!(text);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: widget.label,
                      contentPadding:
                          const EdgeInsets.only(top: 15, bottom: 15),
                      prefixIcon: widget.isPassword
                          ? const Icon(
                              Icons.lock_outlined,
                              color: Colors.grey,
                            ) 
                          : const Icon(Icons.person_outline,
                              color: Colors.grey),
                      suffixIcon: widget.isPassword
                          ? CupertinoButton(
                              child: Icon(
                                _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off, color: Colors.deepPurple.shade200,),
                              onPressed: () {
                                _obscureText = !_obscureText;
                                setState(() {});
                              },
                            )
                          // ignore: prefer_const_constructors
                          : Icon(
                              Icons.assignment_turned_in_rounded,
                              color: Colors.deepPurpleAccent,
                            ),
                            
                      // ignore: prefer_const_constructors
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              if (state.hasError)
                Center(
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
            ],
          );
        });
  }
}
