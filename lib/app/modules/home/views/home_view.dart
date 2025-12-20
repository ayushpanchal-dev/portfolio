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
                  _buildSectionContainer(
                    child: const AboutSection(),
                    key: controller.aboutKey,
                    backgroundColor: AppColors.surface,
                  ),
                  _buildSectionContainer(
                    child: const SkillsSection(),
                    key: controller.skillsKey,
                    backgroundColor: AppColors.background,
                  ),
                  _buildSectionContainer(
                    child: const ResumeSection(),
                    key: controller.resumeKey,
                    backgroundColor: AppColors.surface,
                  ),
                  _buildSectionContainer(
                    child: const ProjectsSection(),
                    key: controller.projectsKey,
                    backgroundColor: AppColors.background,
                  ),
                  _buildSectionContainer(
                    child: const ContactSection(),
                    key: controller.contactKey,
                    backgroundColor: AppColors.surface,
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

  Widget _buildSectionContainer({
    required Widget child,
    required Key key,
    required Color backgroundColor,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      color: backgroundColor,
      constraints: const BoxConstraints(
          minHeight:
              800), // Min height for full screen feel (using fixed reasonable height to avoid layout issues with MediaQuery in some contexts, or could use MediaQuery inside Builder)
      // actually using MediaQuery is better for "full screen".
      // Let's use LayoutBuilder or just MediaQuery.
      child: Builder(builder: (context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          alignment: Alignment.center,
          child: child,
        );
      }),
    );
  }
}
