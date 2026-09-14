import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/about_section.dart';
import '../../../widgets/certificates_section.dart';
import '../../../widgets/contact_section.dart';
import '../../../widgets/footer.dart';
import '../../../widgets/hero_section.dart';
import '../../../widgets/nav_bar.dart';
import '../../../widgets/projects_section.dart';
import '../../../widgets/resume_section.dart';
import '../../../widgets/tech_stack_section.dart';
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
              'Tech Stack',
              Icons.code_rounded,
              () {
                Get.back();
                controller.scrollToSection(controller.skillsKey);
              },
            ),
            _buildDrawerItem(
              'Experience',
              Icons.work_outline,
              () {
                Get.back();
                controller.scrollToSection(controller.resumeKey);
              },
            ),
            _buildDrawerItem(
              'Projects',
              Icons.developer_mode,
              () {
                Get.back();
                controller.scrollToSection(controller.projectsKey);
              },
            ),
            _buildDrawerItem(
              'Certificates',
              Icons.workspace_premium,
              () {
                Get.back();
                controller.scrollToSection(controller.certificatesKey);
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
                    child: const TechStackSection(),
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
                    child: const CertificatesSection(),
                    key: controller.certificatesKey,
                    backgroundColor: AppColors.surface,
                  ),
                  _buildSectionContainer(
                    child: const ContactSection(),
                    key: controller.contactKey,
                    backgroundColor: AppColors.background,
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
      child: Builder(builder: (context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          alignment: Alignment.center,
          child: child,
        );
      }),
    );
  }
}
