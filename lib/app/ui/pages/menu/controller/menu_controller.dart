import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class MenuController extends SimpleNotifier {

  late TabController tabController;
  MenuController(SessionController _sessionController) {
    tabController = TabController(
      length: 2,
      vsync: NavigatorState(),
    );
  }
  @override 
  void dispose(){
    tabController.dispose();
    super.dispose();
  }
}
