import 'package:flutter/material.dart';

class DisposeHandler {
  void disposeTextController(TextEditingController controller) {
    controller.dispose();
  }
}
