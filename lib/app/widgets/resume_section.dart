import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExperienceSection(isMobile),
          const SizedBox(height: 60),
          _buildEducationSection(isMobile),
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
              child: const Icon(Icons.work_outline, size: 32),
            ),
            const SizedBox(width: 12),
            GradientText(
              'Experience',
              gradient: AppGradients.primary,
              style: GoogleFonts.rubik(
                fontSize: isMobile ? 30 : 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 35),
        _buildExperienceItem(
          company: 'WeServeCodes Pvt. Ltd.',
          role: 'Software Developer Level 1',
          date: 'Jul 2025 - Present',
          assetLogo: 'assets/images/wsc_logo.png',
          descriptionItems: [
            'Architecting cross-platform enterprise applications using Flutter, focusing on scalable field operations and data-intensive workflows.',
            'Developed simpliCRM (Field Sales CRM), simpliDELIVER (Logistics Dispatch), and simpliEXPENSE (Expense Management).',
            'Implemented advanced state management with GetX, REST API integration with Dio, and dynamic data grids (PlutoGrid, Syncfusion DataGrid).',
            'Designed offline-aware field synchronization, multi-level approval hierarchies, and role-based dynamic interfaces.'
          ],
          technologies: [
            'Flutter',
            'Dart',
            'GetX',
            'Dio',
            'REST APIs',
            'PlutoGrid',
            'Syncfusion'
          ],
          isMobile: isMobile,
        ),
        _buildExperienceItem(
          company: 'WeServeCodes Pvt. Ltd.',
          role: 'Intern Software Developer',
          date: 'Jan 2025 - Jun 2025',
          assetLogo: 'assets/images/wsc_logo.png',
          descriptionItems: [
            'Built reusable Flutter UI widgets and integrated REST APIs across enterprise web & mobile modules.',
            'Gained hands-on expertise in responsive layout engineering, state management, and enterprise app architecture.'
          ],
          technologies: ['Flutter', 'Dart', 'GetX', 'REST APIs'],
          isMobile: isMobile,
        ),
        _buildExperienceItem(
          company: 'CreArt Solutions',
          role: 'Python Developer',
          date: 'May 2022 - Oct 2023',
          assetLogo: 'assets/images/creart_logo2.png',
          descriptionItems: [
            'Developed backend modules and CRUD services using Python & Django with MySQL database integration.',
            'Designed responsive web interfaces using HTML, CSS, JavaScript, and Bootstrap.',
            'Implemented authentication, database migrations, and web backend workflows.'
          ],
          technologies: [
            'Python',
            'Django',
            'MySQL',
            'HTML/CSS',
            'JavaScript',
            'Bootstrap'
          ],
          isLast: true,
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildEducationSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  AppGradients.primary.createShader(bounds),
              child: const Icon(Icons.school_outlined, size: 32),
            ),
            const SizedBox(width: 12),
            GradientText(
              'Education',
              gradient: AppGradients.primary,
              style: GoogleFonts.rubik(
                fontSize: isMobile ? 30 : 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 35),
        _buildTimelineItem(
          role: 'Master Of Science In Information Technology',
          company:
              'Shri Maneklal M. Patel Institute Of Sciences & Research, GNR\nUniversity - Kadi Sarva Vishwavidyalaya',
          date: '2023-2025',
          descriptionItems: ['8.25 CPI'],
          icon: Icons.school,
          isMobile: isMobile,
        ),
        _buildTimelineItem(
          role: 'Bachelor Of Computer Application',
          company:
              'K.K.Shastri College Of Computer Application\nUniversity - Gujarat University',
          date: '2020-2023',
          descriptionItems: ['7.29 CGPA'],
          icon: Icons.school,
          isMobile: isMobile,
        ),
        _buildTimelineItem(
          role: 'H.S.C',
          company: 'Super High School - Ahmedabad',
          date: '2020',
          descriptionItems: ['Percentage: 65%'],
          icon: Icons.menu_book,
          isLast: true,
          isMobile: isMobile,
        ),
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
    bool isMobile = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                ),
                child: Center(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) =>
                        AppGradients.primary.createShader(bounds),
                    child: Icon(icon, size: 20),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppGradients.primary.colors.first.withOpacity(0.15),
                          AppGradients.primary.colors.last.withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                role,
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
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
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 6),
                  Text(
                    company,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...descriptionItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13.5,
                                  height: 1.45,
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
          // Timeline Indicator
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
                      color: AppColors.surface,
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
                          AppGradients.primary.colors.first.withOpacity(0.15),
                          AppGradients.primary.colors.last.withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
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
                            width: 44,
                            height: 44,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.05),
                              image: DecorationImage(
                                image: AssetImage(widget.assetLogo),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
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
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                                      size: 12),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  widget.date,
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 11.5,
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
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      ...widget.descriptionItems.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) => AppGradients
                                        .primary
                                        .createShader(bounds),
                                    child: const Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 18),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13.5,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 16),
                      Text(
                        'Technologies Used:',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.technologies
                            .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: Text(
                                    tech,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 11.5,
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
