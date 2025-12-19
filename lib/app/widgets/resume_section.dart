import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive_helper.dart';
import 'custom_button.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({Key? key}) : super(key: key);

  Future<void> _launchResume() async {
    final Uri url = Uri.parse(
        'https://drive.google.com/file/d/1K7aBNhoT-FCi_W3dZAHwe-_rnwuiziIn/view?usp=drive_link');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
          Text(
            'Resume',
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
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: 'Download Resume',
            icon: Icons.download_rounded,
            onPressed: _launchResume,
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
            const Icon(Icons.work_outline, color: AppColors.primary, size: 28),
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
          assetLogo: 'assets/images/creart_logo.png',
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
            const Icon(Icons.school_outlined,
                color: AppColors.primary, size: 28),
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(assetLogo),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isMobile
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          role,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.white12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 14,
                                                      color: Colors.white70),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    date,
                                                    style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 14,
                                                      color: Colors.white60),
                                                  const SizedBox(width: 4),
                                                  const Text(
                                                    'Ahmedabad, India',
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
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
                                            color:
                                                Colors.white.withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.white12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 14,
                                                      color: Colors.white70),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    date,
                                                    style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 14,
                                                      color: Colors.white60),
                                                  const SizedBox(width: 4),
                                                  const Text(
                                                    'Ahmedabad, India',
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    company,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...descriptionItems.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "› ",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
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
                      children: technologies
                          .map((tech) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color:
                                          AppColors.primary.withOpacity(0.2)),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    color: AppColors.primary,
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
        ],
      ),
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primary.withOpacity(0.3),
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
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          date,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
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
                                  color: AppColors.textSecondary, fontSize: 16),
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
