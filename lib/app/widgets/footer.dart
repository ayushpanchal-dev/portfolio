import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Let's Work Together",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Looking to collaborate on Flutter web or mobile applications?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'I’m always open to exciting opportunities.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                'Ahmedabad, Gujarat, India',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.email_outlined,
                text: 'Email',
                url: 'mailto:aayushpanchal0708@gmail.com',
                isFontAwesome: false,
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.whatsapp,
                text: 'WhatsApp',
                url: 'https://wa.me/919725816723',
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedinIn,
                text: 'LinkedIn',
                url: 'https://www.linkedin.com/in/ayush2505',
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.instagram,
                text: 'Instagram',
                url:
                    'https://www.instagram.com/a_ayush.711?igsh=OHRlazB6N3I2cWU=',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: 1,
            color: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required dynamic icon,
    required String text,
    required String url,
    bool isFontAwesome = true,
  }) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isFontAwesome
                ? FaIcon(icon, color: Colors.white70, size: 16)
                : Icon(icon, color: Colors.white70, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open link: $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
