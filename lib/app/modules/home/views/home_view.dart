import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/widgets/about_section.dart';
import 'package:my_portfolio/app/widgets/contact_section.dart';
import 'package:my_portfolio/app/widgets/footer.dart';
import 'package:my_portfolio/app/widgets/hero_section.dart';
import 'package:my_portfolio/app/widgets/nav_bar.dart';
import 'package:my_portfolio/app/widgets/projects_section.dart';
import 'package:my_portfolio/app/widgets/resume_section.dart';
import 'package:my_portfolio/app/widgets/skills_section.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: AppColors.surface,
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildDrawerItem(
              'About',
              Icons.person_outline,
              () {
                Get.back();
                controller.scrollToSection(controller.aboutKey);
              },
            ),
            _buildDrawerItem(
              'Skills',
              Icons.code_rounded,
              () {
                Get.back();
                controller.scrollToSection(controller.skillsKey);
              },
            ),
            _buildDrawerItem(
              'Resume',
              Icons.description_outlined,
              () {
                Get.back();
                controller.scrollToSection(controller.resumeKey);
              },
            ),
            _buildDrawerItem(
              'Projects',
              Icons.work_outline,
              () {
                Get.back();
                controller.scrollToSection(controller.projectsKey);
              },
            ),
            _buildDrawerItem(
              'Contact',
              Icons.mail_outline,
              () {
                Get.back();
                controller.scrollToSection(controller.contactKey);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    key: controller.homeKey,
                    child: const HeroSection(),
                  ),
                  Container(
                    key: controller.aboutKey,
                    child: const AboutSection(),
                  ),
                  Container(
                    key: controller.skillsKey,
                    child: const SkillsSection(),
                  ),
                  Container(
                    key: controller.resumeKey,
                    child: const ResumeSection(),
                  ),
                  Container(
                    key: controller.projectsKey,
                    child: const ProjectsSection(),
                  ),
                  Container(
                    key: controller.contactKey,
                    child: const ContactSection(),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
