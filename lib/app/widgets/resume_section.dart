import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({Key? key}) : super(key: key);

  // Resume launch moved to Hero Section

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 50,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Centered Title and Divider
              Column(
                children: [
                  GradientText(
                    'Resume',
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
                ],
              ),
            ],
          ),
          const SizedBox(height: 50),
          _buildExperienceSection(isMobile),
          const SizedBox(height: 50),
          _buildEducationSection(),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  AppGradients.primary.createShader(bounds),
              child: const Icon(Icons.work_outline, size: 28),
            ),
            const SizedBox(width: 10),
            Text(
              'Experience',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        _buildExperienceItem(
          company: 'WeServeCodes Pvt Ltd.',
          role: 'SDE -1 (Flutter Developer)',
          date: 'Jan 2025 - Present',
          assetLogo: 'assets/images/wsc_logo.png',
          descriptionItems: [
            'Worked on enterprise-grade web and mobile applications using Flutter, contributing to scalable and role-based business modules.',
            'Developed and maintained CRM, Expense Management, and Delivery Management modules, focusing on clean architecture and modular design.',
            'Implemented state management using GetX, ensuring efficient UI updates and predictable application behavior.',
            'Gained strong hands-on experience in Flutter Web & Mobile, improving performance, responsiveness, and code reusability.'
          ],
          technologies: ['Flutter', 'Dart', 'Firebase'],
          isMobile: isMobile,
        ),
        _buildExperienceItem(
          company: 'CreArt Solution',
          role: 'Jr. Python Developer',
          date: 'May 2022 - Oct 2023',
          assetLogo: 'assets/images/creart_logo2.png',
          descriptionItems: [
            'Worked as a full-stack web developer on academic and NGO-based projects, gaining hands-on industry experience in real-world application development.',
            'Built responsive and user-friendly UI components using HTML, CSS, and Bootstrap, improving accessibility across devices.',
            'Developed backend modules in Django, handling authentication, CRUD operations, and database integration.',
            'Collaborated with mentors and team members to understand software development workflows, version control, and debugging practices.'
          ],
          technologies: [
            'Python',
            'Django',
            'HTML',
            'CSS',
            'Javascript',
            'Bootstrap'
          ],
          isLast: true,
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  AppGradients.primary.createShader(bounds),
              child: const Icon(Icons.school_outlined, size: 28),
            ),
            const SizedBox(width: 10),
            Text(
              'Education',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        _buildTimelineItem(
          role: 'Master Of Science In Information Technology',
          company:
              'Shri Maneklal M. Patel Institute Of Sciences & Research, GNR\nUniversity - Kadi Sarva Vishwavidyalaya',
          date: '2023-2025',
          descriptionItems: ['8.25 CPI'],
          icon: Icons.school,
        ),
        _buildTimelineItem(
          role: 'Bachelor Of Computer Application',
          company:
              'K.K.Shastri College Of Computer Application\nUniversity - Gujarat University',
          date: '2020-2023',
          descriptionItems: ['7.29 CGPA'],
          icon: Icons.school,
        ),
        _buildTimelineItem(
            role: 'H.S.C',
            company: 'Super High School - Ahmedabad',
            date: '2020',
            descriptionItems: ['Percentage: 65%'],
            icon: Icons.menu_book,
            isLast: true),
        // _buildTimelineItem(
        //   role: 'S.S.C.',
        //   company: 'Super High School - Ahmedabad',
        //   date: '2018',
        //   descriptionItems: ['Percentage: 75%'],
        //   icon: Icons.menu_book,
        //   isLast: true,
        // ),
      ],
    );
  }

  Widget _buildExperienceItem({
    required String company,
    required String role,
    required String date,
    required String assetLogo,
    required List<String> descriptionItems,
    required List<String> technologies,
    bool isLast = false,
    bool isMobile = false,
  }) {
    return _ExperienceCard(
      company: company,
      role: role,
      date: date,
      assetLogo: assetLogo,
      descriptionItems: descriptionItems,
      technologies: technologies,
      isLast: isLast,
      isMobile: isMobile,
    );
  }

  Widget _buildTimelineItem({
    required String role,
    required String company,
    required String date,
    required List<String> descriptionItems,
    required IconData icon,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                ),
                child: Center(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) =>
                        AppGradients.primary.createShader(bounds),
                    child: Icon(icon, size: 24),
                  ),
                ),
              ),
              // Line connection
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppGradients.primary.colors.first.withOpacity(0.1),
                          AppGradients.primary.colors.last.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          role,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    company,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ...descriptionItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final String company;
  final String role;
  final String date;
  final String assetLogo;
  final List<String> descriptionItems;
  final List<String> technologies;
  final bool isLast;
  final bool isMobile;

  const _ExperienceCard({
    Key? key,
    required this.company,
    required this.role,
    required this.date,
    required this.assetLogo,
    required this.descriptionItems,
    required this.technologies,
    this.isLast = false,
    this.isMobile = false,
  }) : super(key: key);

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.primary,
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface, // Inner hole
                    ),
                  ),
                ),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppGradients.primary.colors.first.withOpacity(0.1),
                          AppGradients.primary.colors.last.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.primary.withOpacity(0.5)
                          : Colors.white10,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isHovered
                            ? AppColors.primary.withOpacity(0.15)
                            : Colors.black.withOpacity(0.2),
                        blurRadius: _isHovered ? 20 : 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  transform: _isHovered
                      ? (Matrix4.identity()..translate(0, -5))
                      : Matrix4.identity(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white.withOpacity(0.05),
                              image: DecorationImage(
                                image: AssetImage(widget.assetLogo),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.isMobile
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.role,
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          // Mobile Badge
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ShaderMask(
                                                  blendMode: BlendMode.srcIn,
                                                  shaderCallback: (bounds) =>
                                                      AppGradients.primary
                                                          .createShader(bounds),
                                                  child: const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 14),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  widget.date,
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.role,
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white12),
                                            ),
                                            child: Row(
                                              children: [
                                                ShaderMask(
                                                  blendMode: BlendMode.srcIn,
                                                  shaderCallback: (bounds) =>
                                                      AppGradients.primary
                                                          .createShader(bounds),
                                                  child: const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 14),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  widget.date,
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 4),
                                GradientText(
                                  widget.company,
                                  gradient: AppGradients.primary,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ...widget.descriptionItems.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) => AppGradients
                                        .primary
                                        .createShader(bounds),
                                    child: const Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 20),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 20),
                      Text(
                        'Technologies Used:',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.technologies
                            .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: Text(
                                    tech,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
