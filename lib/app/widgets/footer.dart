import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import 'gradient_text.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background, // Match default background for blending
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle Gradient Overlay
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background,
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GradientText(
                  "Let's Build Something Amazing",
                  gradient: AppGradients.primary,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Looking for a dedicated Flutter developer? I’m ready to help.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 25),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _HoverSocialButton(
                      icon: Icons.email_outlined,
                      text: 'Email Me',
                      url: 'mailto:aayushpanchal0708@gmail.com',
                      isFontAwesome: false,
                    ),
                    _HoverSocialButton(
                      icon: FontAwesomeIcons.whatsapp,
                      text: 'WhatsApp',
                      url: 'https://wa.me/919725816723',
                    ),
                    _HoverSocialButton(
                      icon: FontAwesomeIcons.linkedinIn,
                      text: 'LinkedIn',
                      url: 'https://www.linkedin.com/in/ayush2505',
                    ),
                    _HoverSocialButton(
                      icon: FontAwesomeIcons.instagram,
                      text: 'Instagram',
                      url:
                          'https://www.instagram.com/a_ayush.711?igsh=OHRlazB6N3I2cWU=',
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Location with simple style
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: AppColors.primary, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Ahmedabad, India',
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '© 2025 Ayush Panchal. All rights reserved.',
                  style: GoogleFonts.poppins(
                    color: Colors.white24,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverSocialButton extends StatefulWidget {
  final dynamic icon;
  final String text;
  final String url;
  final bool isFontAwesome;

  const _HoverSocialButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.url,
    this.isFontAwesome = true,
  }) : super(key: key);

  @override
  State<_HoverSocialButton> createState() => _HoverSocialButtonState();
}

class _HoverSocialButtonState extends State<_HoverSocialButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch ${widget.url}';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open link: ${widget.url}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -5))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.5)
                  : Colors.white12,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isFontAwesome
                  ? FaIcon(widget.icon,
                      color: _isHovered ? Colors.white : Colors.white70,
                      size: 20)
                  : Icon(widget.icon,
                      color: _isHovered ? Colors.white : Colors.white70,
                      size: 22),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: GoogleFonts.poppins(
                  color: _isHovered ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
