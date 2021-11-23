// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomField({
    Key? key,
    this.onChanged,
    required this.label,
    this.inputType,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
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
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black12,),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                        contentPadding:
                            const EdgeInsets.only(top: 15, bottom: 15),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white54,
                        labelText: widget.label,
                        //border: const OutlineInputBorder(),
                        suffixIcon: widget.isPassword
                            ? CupertinoButton(
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off, color: Colors.deepPurple.shade400,),
                                onPressed: () {
                                  _obscureText = !_obscureText;
                                  setState(() {});
                                },
                              )
                            : Container(
                                width: 0.1,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              if (state.hasError)
                Center(
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.redAccent),
                    
                  ),
                ),
            ],
          );
        });
  }
}
