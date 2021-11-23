// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:consultoria/app/inject_dependencies.dart';
import 'package:consultoria/app/utils/extra.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//import 'modulos/inicio.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();
  runApp(
    const Extra(),
  );
}