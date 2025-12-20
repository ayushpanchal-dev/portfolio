import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
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
          "As a passionate Flutter developer, I specialize in building beautiful, high-performance mobile applications that offer seamless user experiences across Android and iOS. I enjoy transforming complex ideas into intuitive and responsive UIs using Flutter’s powerful toolkit and clean architecture principles.\n\nFrom interactive design to efficient state management with tools like GetX and BLoC, I focus on writing clean, maintainable code that brings apps to life. I’ve worked with Firebase, REST APIs, real-time features, and more—ensuring every app I develop is scalable, dynamic, and user-focused.\n\nI'm always eager to learn, experiment with new Flutter capabilities, and contribute to projects that make a real-world impact. Whether it’s creating sleek interfaces or optimizing app performance, I’m committed to delivering quality in every build.",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 40),
        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatCard('1.5+', 'Years Experience'),
              const SizedBox(height: 20),
              _buildStatCard('10+', 'Projects Completed'),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildStatCard('1.5+', 'Years Experience'),
              const SizedBox(width: 30),
              _buildStatCard('10+', 'Projects Completed'),
            ],
          ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
