import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_helper.dart';
import 'custom_button.dart';
import 'typewriter_text.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 50,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            Color(0xFF2E2A5C), // Dark purple tint
          ],
        ),
      ),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text Content
          isDesktop
              ? Expanded(flex: 6, child: _buildTextContent(isDesktop))
              : _buildTextContent(isDesktop),
          if (isDesktop) const SizedBox(width: 40),
          // Hero Image/Illustration
          isDesktop
              ? Expanded(flex: 5, child: Center(child: _buildHeroImage()))
              : (!ResponsiveHelper.isMobile(context)
                  ? _buildHeroImage()
                  : const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildTextContent(bool isDesktop) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          "HEY, I'M AYUSH PANCHAL",
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.rubik(
            fontSize: isDesktop ? 40 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
        TypewriterText(
          texts: const [
            'A Flutter Developer',
            'Mobile App Developer',
            'Software Engineer',
          ],
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          duration: const Duration(milliseconds: 1500),
        ),
        const SizedBox(height: 10),
        Text(
          'Transforming ideas into interactive \nApplication for seamless user experiences...',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Resume",
              onPressed: () {
                final controller = Get.find<HomeController>();
                controller.scrollToSection(controller.resumeKey);
              },
              isPrimary: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 300,
      width: 300,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/profile_ayush.jpg'
              // 'assets/images/avatar.jpg',
              ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
