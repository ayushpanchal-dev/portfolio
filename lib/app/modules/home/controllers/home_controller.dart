import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final resumeKey = GlobalKey();
  final contactKey = GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> scrollToSection(GlobalKey key) async {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
