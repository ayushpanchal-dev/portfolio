import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';

class SingleTechCard {
  final String title;
  final IconData icon;
  final Color accentColor;

  SingleTechCard({
    required this.title,
    required this.icon,
    required this.accentColor,
  });
}

class TechStackSection extends StatelessWidget {
  const TechStackSection({Key? key}) : super(key: key);

  static final List<SingleTechCard> techList = [
    SingleTechCard(
      title: "Flutter",
      icon: FontAwesomeIcons.flutter,
      accentColor: const Color(0xFF02569B),
    ),
    SingleTechCard(
      title: "Dart",
      icon: FontAwesomeIcons.code,
      accentColor: const Color(0xFF0175C2),
    ),
    SingleTechCard(
      title: "Firebase",
      icon: FontAwesomeIcons.fire,
      accentColor: const Color(0xFFFFCA28),
    ),
    SingleTechCard(
      title: "REST APIs",
      icon: FontAwesomeIcons.networkWired,
      accentColor: const Color(0xFF818CF8),
    ),
    SingleTechCard(
      title: "GetX",
      icon: FontAwesomeIcons.bolt,
      accentColor: const Color(0xFFEC4899),
    ),
    SingleTechCard(
      title: "Dio HTTP",
      icon: FontAwesomeIcons.paperPlane,
      accentColor: const Color(0xFF38BDF8),
    ),
    SingleTechCard(
      title: "PlutoGrid",
      icon: FontAwesomeIcons.table,
      accentColor: const Color(0xFF10B981),
    ),
    SingleTechCard(
      title: "Syncfusion Grid",
      icon: FontAwesomeIcons.chartSimple,
      accentColor: const Color(0xFF6366F1),
    ),
    SingleTechCard(
      title: "Git & GitHub",
      icon: FontAwesomeIcons.github,
      accentColor: Colors.white70,
    ),
    SingleTechCard(
      title: "Android",
      icon: FontAwesomeIcons.android,
      accentColor: const Color(0xFF3DDC84),
    ),
    SingleTechCard(
      title: "Xcode / iOS",
      icon: FontAwesomeIcons.apple,
      accentColor: const Color(0xFF38BDF8),
    ),
    SingleTechCard(
      title: "Postman & VS Code",
      icon: FontAwesomeIcons.terminal,
      accentColor: const Color(0xFFFF6C37),
    ),
    SingleTechCard(
      title: "Python & Django",
      icon: FontAwesomeIcons.python,
      accentColor: const Color(0xFF306998),
    ),
    SingleTechCard(
      title: "MySQL Database",
      icon: FontAwesomeIcons.database,
      accentColor: const Color(0xFFF29111),
    ),
    SingleTechCard(
      title: "Responsive UI",
      icon: FontAwesomeIcons.laptopCode,
      accentColor: const Color(0xFFA855F7),
    ),
    SingleTechCard(
      title: "UI/UX Design",
      icon: FontAwesomeIcons.palette,
      accentColor: const Color(0xFFF43F5E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = !isMobile && !isDesktop;

    final crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 60,
      ),
      child: Column(
        children: [
          GradientText(
            'Tech Stack',
            gradient: AppGradients.primary,
            style: GoogleFonts.rubik(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Technologies, frameworks, tools, and platforms I work with",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 50),

          // 4-Column Grid of Cards matching Reference Image
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: isMobile ? 2.5 : 3.2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemCount: techList.length,
            itemBuilder: (context, index) {
              return _TechCardItem(tech: techList[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _TechCardItem extends StatefulWidget {
  final SingleTechCard tech;
  const _TechCardItem({Key? key, required this.tech}) : super(key: key);

  @override
  State<_TechCardItem> createState() => _TechCardItemState();
}

class _TechCardItemState extends State<_TechCardItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF11111E), // Dark navy background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? widget.tech.accentColor.withOpacity(0.8)
                : widget.tech.accentColor.withOpacity(0.2),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.tech.accentColor.withOpacity(0.2)
                  : Colors.black.withOpacity(0.15),
              blurRadius: _isHovered ? 15 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -4))
            : Matrix4.identity(),
        child: Row(
          children: [
            FaIcon(
              widget.tech.icon,
              color: widget.tech.accentColor,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                widget.tech.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: widget.tech.accentColor == Colors.white70
                      ? Colors.white
                      : widget.tech.accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
