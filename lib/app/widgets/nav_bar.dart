import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/home/controllers/home_controller.dart';

import '../utils/responsive_helper.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Put controller if not found, to be safe
    final controller = Get.put(HomeController());
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => controller.scrollToSection(controller.homeKey),
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF693BFF), // Primary color
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile_ayush.jpg',
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'AYUSH PANCHAL',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Flutter Developer',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isDesktop)
            Row(
              children: [
                _buildNavItem(
                  'About',
                  () => controller.scrollToSection(controller.aboutKey),
                ),
                _buildNavItem(
                  'Skills',
                  () => controller.scrollToSection(controller.skillsKey),
                ),
                _buildNavItem(
                  'Resume',
                  () => controller.scrollToSection(controller.resumeKey),
                ),
                _buildNavItem(
                  'Projects',
                  () => controller.scrollToSection(controller.projectsKey),
                ),
                _buildNavItem(
                  'Contact',
                  () => controller.scrollToSection(controller.contactKey),
                ),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: () => controller.openDrawer(),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
