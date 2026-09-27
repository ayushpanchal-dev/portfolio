import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import '../modules/home/controllers/home_controller.dart';
import 'gradient_text.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : null;
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background subtle gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background,
                    AppColors.primary.withOpacity(0.04),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Top border divider line
              Divider(height: 1, thickness: 1, color: Colors.white.withOpacity(0.08)),

              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 40,
                    vertical: isMobile ? 40 : 60,
                  ),
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIdentityColumn(),
                            const SizedBox(height: 36),
                            _buildQuickLinksColumn(homeController),
                            const SizedBox(height: 36),
                            _buildConnectColumn(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 4, child: _buildIdentityColumn()),
                            const SizedBox(width: 40),
                            Expanded(flex: 3, child: _buildQuickLinksColumn(homeController)),
                            const SizedBox(width: 40),
                            Expanded(flex: 3, child: _buildConnectColumn()),
                          ],
                        ),
                ),
              ),

              // Bottom Bar Divider
              Divider(height: 1, thickness: 1, color: Colors.white.withOpacity(0.06)),

              // Bottom Copyright Bar
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 40,
                    vertical: 20,
                  ),
                  child: isMobile
                      ? Column(
                          children: [
                            Text(
                              '© 2026 Ayush Panchal. All rights reserved.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white38,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBuiltWithFlutter(),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '© 2026 Ayush Panchal. All rights reserved.',
                              style: GoogleFonts.poppins(
                                color: Colors.white38,
                                fontSize: 13,
                              ),
                            ),
                            _buildBuiltWithFlutter(),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          'Ayush Panchal',
          gradient: AppGradients.primary,
          style: GoogleFonts.rubik(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Flutter Developer • Software Developer',
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Building modern, scalable, and user-friendly cross-platform applications.',
          style: GoogleFonts.poppins(
            color: Colors.white38,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              'Ahmedabad, India',
              style: GoogleFonts.poppins(
                color: Colors.white60,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinksColumn(HomeController? controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        _FooterNavLink(
          label: 'About',
          onTap: () => controller?.scrollToSection(controller.aboutKey),
        ),
        _FooterNavLink(
          label: 'Skills',
          onTap: () => controller?.scrollToSection(controller.skillsKey),
        ),
        _FooterNavLink(
          label: 'Experience',
          onTap: () => controller?.scrollToSection(controller.resumeKey),
        ),
        _FooterNavLink(
          label: 'Projects',
          onTap: () => controller?.scrollToSection(controller.projectsKey),
        ),
        _FooterNavLink(
          label: 'Certificates',
          onTap: () => controller?.scrollToSection(controller.certificatesKey),
        ),
      ],
    );
  }

  Widget _buildConnectColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Connect",
          style: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        const _FooterSocialItem(
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          url: 'https://github.com/ayushpanchal-dev/apayush',
        ),
        const _FooterSocialItem(
          icon: FontAwesomeIcons.linkedinIn,
          label: 'LinkedIn',
          url: 'https://www.linkedin.com/in/ayush2505',
        ),
        const _FooterSocialItem(
          icon: Icons.email_outlined,
          label: 'Email',
          url: 'mailto:aayushpanchal0708@gmail.com',
          isFontAwesome: false,
        ),
        const _FooterSocialItem(
          icon: FontAwesomeIcons.whatsapp,
          label: 'WhatsApp',
          url: 'https://wa.me/919725816723',
        ),
      ],
    );
  }

  Widget _buildBuiltWithFlutter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Built with ',
          style: GoogleFonts.poppins(
            color: Colors.white38,
            fontSize: 13,
          ),
        ),
        const FaIcon(
          FontAwesomeIcons.flutter,
          color: Color(0xFF42A5F5),
          size: 14,
        ),
        Text(
          ' Flutter',
          style: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _FooterNavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterNavLink({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_FooterNavLink> createState() => _FooterNavLinkState();
}

class _FooterNavLinkState extends State<_FooterNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: Matrix4.translationValues(_isHovered ? 4 : 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
                SizedBox(width: _isHovered ? 4 : 0),
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    color: _isHovered ? Colors.white : Colors.white60,
                    fontSize: 14,
                    fontWeight: _isHovered ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterSocialItem extends StatefulWidget {
  final dynamic icon;
  final String label;
  final String url;
  final bool isFontAwesome;

  const _FooterSocialItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.url,
    this.isFontAwesome = true,
  }) : super(key: key);

  @override
  State<_FooterSocialItem> createState() => _FooterSocialItemState();
}

class _FooterSocialItemState extends State<_FooterSocialItem> {
  bool _isHovered = false;

  Future<void> _launch() async {
    final Uri uri = Uri.parse(widget.url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch ${widget.url}';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open link: ${widget.url}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _launch,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: Matrix4.translationValues(_isHovered ? 4 : 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isFontAwesome
                    ? FaIcon(
                        widget.icon,
                        color: _isHovered ? AppColors.primary : Colors.white60,
                        size: 16,
                      )
                    : Icon(
                        widget.icon,
                        color: _isHovered ? AppColors.primary : Colors.white60,
                        size: 18,
                      ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    color: _isHovered ? Colors.white : Colors.white60,
                    fontSize: 14,
                    fontWeight: _isHovered ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
