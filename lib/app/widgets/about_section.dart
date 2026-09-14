import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_helper.dart';
import '../theme/app_gradients.dart';
import 'gradient_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

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
          GradientText(
            'About Me',
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
          const SizedBox(height: 50),
          _buildBioContent(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildBioContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "I am a Software Developer Level 1 at WeServeCodes Pvt. Ltd., specializing in cross-platform Flutter application engineering. My core expertise lies in building enterprise-grade mobile and web applications that streamline field sales operations, dispatch & logistics workflows, and multi-tier financial expense management systems.\n\nI architect robust Flutter applications utilizing GetX state management, Dio HTTP networking, dynamic data grids (PlutoGrid & Syncfusion DataGrid), real-time GPS tracking, and offline-aware field synchronization. I focus on clean architecture, responsive layouts across devices, and strict business validation compliance.\n\nWith a background in computer science and full-stack web development, I combine strong analytical problem-solving skills with practical mobile app engineering to build performant, user-centric software solutions.",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 40),
        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatCard('SDE-1', 'WeServeCodes Pvt. Ltd.'),
              const SizedBox(height: 20),
              _buildStatCard('3+', 'Enterprise Products'),
              const SizedBox(height: 20),
              _buildStatCard('15+', 'Verified Certifications'),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildStatCard('SDE-1', 'WeServeCodes Pvt. Ltd.'),
              const SizedBox(width: 30),
              _buildStatCard('3+', 'Enterprise Products'),
              const SizedBox(width: 30),
              _buildStatCard('15+', 'Verified Certifications'),
            ],
          ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          GradientText(
            value,
            gradient: AppGradients.primary,
            style: GoogleFonts.rubik(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
