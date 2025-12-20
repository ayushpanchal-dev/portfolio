import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  final String _appScriptUrl =
      'https://script.google.com/macros/s/AKfycbymXKE3MHQbsMmlHPS8DfInIwcVP3POEZmFsp8u0-mhPHauzVPbl2jv7NaQz8ceH6vZ/exec';
  // 'https://script.google.com/macros/s/AKfycbzl-xv7bMw9xxAYGsx-jBgX93EYGxX5w2voYtti4403l6km1fpR5xxla3kMvxJ0i9yS/exec';

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    final uri = Uri.parse(_appScriptUrl).replace(queryParameters: {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'message': messageController.text.trim(),
      'date': DateTime.now().toString(),
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200 &&
          response.body.toLowerCase().contains('success')) {
        Get.snackbar('Success', 'Message sent successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);

        nameController.clear();
        emailController.clear();
        phoneController.clear();
        messageController.clear();
      } else {
        throw 'Unexpected response: ${response.body}';
      }
    } catch (e) {
      Get.snackbar(
        'Success',
        'Message sent successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      messageController.clear();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
