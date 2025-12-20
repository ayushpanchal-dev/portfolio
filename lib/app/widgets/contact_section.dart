import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/contact/controllers/contact_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';
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
                GradientText(
                  'Contact Me',
                  gradient: AppGradients.primary,
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
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF111118), // Very dark card background
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              'Contact Me',
              gradient: AppGradients.primary,
              style: GoogleFonts.rubik(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // No header inside the form based on reference image 1, but user asked for "Form design as my image"
            // The image `uploaded_image_0_1766211579378.png` shows Name, Email, Subject, Message inputs.
            // It does NOT show "Contact Me" text inside.

            // Row for Name and Email if desktop
            if (ResponsiveHelper.isDesktop(context))
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Name *"),
                        const SizedBox(height: 8),
                        _buildTextField(controller.nameController, 'Your Name',
                            Icons.person),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Email *"),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller.emailController,
                          'your.email@example.com',
                          Icons.email,
                          isEmail: true,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else ...[
              _buildLabel("Name *"),
              const SizedBox(height: 8),
              _buildTextField(
                  controller.nameController, 'Your Name', Icons.person),
              const SizedBox(height: 20),
              _buildLabel("Email *"),
              const SizedBox(height: 8),
              _buildTextField(
                controller.emailController,
                'your.email@example.com',
                Icons.email,
                isEmail: true,
              ),
            ],
            const SizedBox(height: 20),

            _buildLabel(
                "Phone No (Optional)"), // Keeping Phone as it was there, or change to Subject?
            // User image has "Subject". Let's assume we keep Phone or change to Subject if requested.
            // User said "just change contact me form design as my image". The image has "Subject".
            // I should probably stick to existing fields but style them. Let's keep Phone for now as logic changes might be risky without asking.
            const SizedBox(height: 8),
            _buildTextField(
              controller.phoneController,
              'Phone No',
              Icons.phone,
              isPhone: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 20),

            _buildLabel("Message *"),
            const SizedBox(height: 8),
            _buildTextField(
              controller.messageController,
              'Tell me about your project...',
              Icons.message,
              maxLines: 5,
            ),
            const SizedBox(height: 30),

            // Gradient Button
            InkWell(
              onTap: () => controller.submitForm(),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: AppGradients.primary, // Use the new Blue-Purple
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppGradients.primary.colors.first.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Send Message',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.white, // White label
        fontSize: 14,
        fontWeight: FontWeight.w500,
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
      style: const TextStyle(color: Colors.white70),
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
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
        // Remove prefix icon if not in image, or keep subtle. Keeping subtle.
        // Image doesn't show prefix icons inside the box, but let's keep it for UX or remove if strictly following image.
        // Reference image shows NO icon inside, just text. Let's remove icon to match strictly.
        // prefixIcon: Icon(icon, color: AppColors.primary),
        alignLabelWithHint: true,
        filled: true,
        fillColor:
            const Color(0xFF1A1A24), // Slightly lighter than card, very dark
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: Color(0xFF0072FF), width: 1), // Blue focus
        ),
      ),
    );
  }
}
