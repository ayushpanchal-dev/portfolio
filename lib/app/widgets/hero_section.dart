import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';
import 'typewriter_text.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      // Ensure it takes at least the full screen height (minus navbar approx 80px)
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 10,
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
      child: Center(
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
      ),
    );
  }

  Widget _buildTextContent(bool isDesktop) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hello, I'm",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        GradientText(
          "Ayush Panchal",
          gradient: AppGradients.primary,
          style: GoogleFonts.rubik(
            fontSize: isDesktop ? 60 : 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => AppGradients.primary.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: TypewriterText(
            texts: const [
              'A Flutter Developer',
              'Mobile App Developer',
              'Software Engineer',
            ],
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:
                  Colors.white, // Colors.white is necessary for srcIn blendmode
            ),
            duration: const Duration(milliseconds: 1500),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Passionate about creating exceptional digital experiences\nthrough clean code and innovative solutions. Specializing\nin mobile technologies and user-centered design.',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            // "View My Work" Button - Gradient
            Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  final controller = Get.find<HomeController>();
                  controller.scrollToSection(controller.projectsKey);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                ),
                child: Text(
                  "View My Work",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // "Get In Touch" Button - Outlined
            OutlinedButton(
              onPressed: () {
                final controller = Get.find<HomeController>();
                controller.scrollToSection(controller.contactKey);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF0072FF), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
              ),
              child: Text(
                "Get In Touch",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        // Social Icons Row
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            const _SocialIconButton(
              icon: FontAwesomeIcons.linkedinIn,
              url: 'https://www.linkedin.com/in/ayush2505',
              tooltip: 'LinkedIn',
            ),
            const SizedBox(width: 20),
            const _SocialIconButton(
              icon: Icons.email_outlined,
              url: 'mailto:aayushpanchal0708@gmail.com',
              tooltip: 'Email',
              isFontAwesome: false,
            ),
            const SizedBox(width: 20),
            const _SocialIconButton(
              icon: Icons.remove_red_eye_outlined,
              url:
                  'https://drive.google.com/file/d/1K7aBNhoT-FCi_W3dZAHwe-_rnwuiziIn/view?usp=drive_link',
              tooltip: 'View Resume',
              isFontAwesome: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height:
          400, // Slightly larger as requested "looks good like whole screen"
      width: 400,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/profile_ayush.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final dynamic icon;
  final String url;
  final String tooltip;
  final bool isFontAwesome;

  const _SocialIconButton({
    Key? key,
    required this.icon,
    required this.url,
    this.tooltip = '',
    this.isFontAwesome = true,
  }) : super(key: key);

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              gradient: _isHovered
                  ? AppGradients.primary
                  : const LinearGradient(
                      colors: [Colors.transparent, Colors.transparent],
                    ),
              borderRadius: BorderRadius.circular(10), // Rounded corners
              color: _isHovered
                  ? null
                  : Colors.white.withOpacity(0.05), // Normal state color
              border: _isHovered ? null : Border.all(color: Colors.white12),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: widget.isFontAwesome
                  ? FaIcon(
                      widget.icon,
                      color: _isHovered ? Colors.white : Colors.white70,
                      size: 20,
                    )
                  : Icon(
                      widget.icon,
                      color: _isHovered ? Colors.white : Colors.white70,
                      size: 22,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
