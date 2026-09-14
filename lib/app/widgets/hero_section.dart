import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'developer_background_painter.dart';
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

    return DeveloperBackgroundWidget(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: size.height,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 20,
          vertical: 40,
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
              // Hero Image / Developer Frame
              isDesktop
                  ? Expanded(flex: 5, child: Center(child: _buildHeroImage()))
                  : (!ResponsiveHelper.isMobile(context)
                      ? _buildHeroImage()
                      : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(bool isDesktop) {
    final List<String> keywords = [
      'Flutter',
      'Dart',
      'GetX',
      'REST APIs',
      'Firebase',
      'Responsive UI',
      'Enterprise Applications',
    ];

    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Role pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981), // Green active dot
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Software Developer Level 1 @ WeServeCodes",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Hello, I'm",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        GradientText(
          "AYUSH PANCHAL",
          gradient: AppGradients.primary,
          style: GoogleFonts.rubik(
            fontSize: isDesktop ? 54 : 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => AppGradients.primary.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: TypewriterText(
            texts: const [
              'Flutter Developer',
              'Enterprise App Engineer',
              'Cross-Platform Developer',
            ],
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 26 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            duration: const Duration(milliseconds: 1600),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Building scalable, responsive and user-friendly mobile applications with Flutter.',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 35),

        // Call to action buttons
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 15,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                ),
                child: Text(
                  "View Enterprise Work",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                final controller = Get.find<HomeController>();
                controller.scrollToSection(controller.contactKey);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF0072FF), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
              ),
              child: Text(
                "Get In Touch",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Social Icons Row
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            const _SocialIconButton(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/ayushpanchal-dev/apayush',
              tooltip: 'GitHub',
            ),
            const SizedBox(width: 16),
            const _SocialIconButton(
              icon: FontAwesomeIcons.linkedinIn,
              url: 'https://www.linkedin.com/in/ayush2505',
              tooltip: 'LinkedIn',
            ),
            const SizedBox(width: 16),
            const _SocialIconButton(
              icon: Icons.email_outlined,
              url: 'mailto:aayushpanchal0708@gmail.com',
              tooltip: 'Email',
              isFontAwesome: false,
            ),
            const SizedBox(width: 16),
            const _SocialIconButton(
              icon: Icons.description_outlined,
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
      height: 380,
      width: 380,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.primary,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/profile_ayush.jpg'),
            fit: BoxFit.cover,
          ),
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
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              gradient: _isHovered
                  ? AppGradients.primary
                  : const LinearGradient(
                      colors: [Colors.transparent, Colors.transparent],
                    ),
              borderRadius: BorderRadius.circular(10),
              color: _isHovered ? null : Colors.white.withOpacity(0.05),
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
                      size: 18,
                    )
                  : Icon(
                      widget.icon,
                      color: _isHovered ? Colors.white : Colors.white70,
                      size: 20,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
