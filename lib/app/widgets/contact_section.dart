import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/contact/controllers/contact_controller.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_helper.dart';
import 'snake_game_widget.dart';

class ContactSection extends GetView<ContactController> {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(ContactController());

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.isDesktop(context) ? 100 : 20,
        vertical: 50,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveHelper.isDesktop(context)) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(width: 400, child: SnakeGameWidget()),
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(child: _buildContactForm(context)),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Contact Me',
                  style: GoogleFonts.rubik(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "I'm open for new opportunities. Let's connect!",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 30),
                Center(child: SizedBox(width: 300, child: SnakeGameWidget())),
                const SizedBox(height: 30),
                _buildContactForm(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveHelper.isDesktop(context)) ...[
              Text(
                'Contact Me',
                style: GoogleFonts.rubik(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "I'm open for new opportunities. Let's connect!",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 30),
            ],
            _buildTextField(controller.nameController, 'Name', Icons.person),
            const SizedBox(height: 20),
            _buildTextField(
              controller.emailController,
              'Email',
              Icons.email,
              isEmail: true,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller.phoneController,
              'Phone No (Optional)',
              Icons.phone,
              isPhone: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller.messageController,
              'Message',
              Icons.message,
              maxLines: 5,
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => controller.submitForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Send Message',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isEmail = false,
    bool isPhone = false,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      autovalidateMode:
          AutovalidateMode.disabled, // Validate only touched fields
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (!isPhone && (value == null || value.isEmpty)) {
          return '$hint is required';
        }
        if (isEmail && !GetUtils.isEmail(value!)) {
          return 'Invalid email';
        }
        if (isPhone &&
            value != null &&
            value.isNotEmpty &&
            !GetUtils.isPhoneNumber(value)) {
          return 'Invalid phone number';
        }
        return null; // Return null if valid
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
