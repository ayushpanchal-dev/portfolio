import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_helper.dart';

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
          Text(
            'About Me',
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
          const SizedBox(height: 50),
          _buildBioContent(context, isMobile),
          // isMobile
          //     ? Column(
          //         children: [
          //           _buildProfileImage(),
          //           const SizedBox(height: 30),
          //           _buildBioContent(context, isMobile),
          //         ],
          //       )
          //     : Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Expanded(
          //               flex: 4, child: Center(child: _buildProfileImage())),
          //           const SizedBox(width: 50),
          //           Expanded(
          //               flex: 6, child: _buildBioContent(context, isMobile)),
          //         ],
          //       ),
        ],
      ),
    );
  }

  // Widget _buildProfileImage() {
  //   return Container(
  //     height: 320,
  //     width: 320,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       image: const DecorationImage(
  //         image: AssetImage('assets/images/profile_ayush.jpg'),
  //         fit: BoxFit.contain,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppColors.primary.withOpacity(0.2),
  //           blurRadius: 20,
  //           offset: const Offset(0, 10),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
          Text(
            value,
            style: GoogleFonts.rubik(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
