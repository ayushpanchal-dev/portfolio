import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/models/project.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import 'project_details_dialog.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index; // To pick a gradient

  const ProjectCard({Key? key, required this.project, this.index = 0})
      : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Pick a gradient based on index
    final gradient = AppGradients
        .cardGradients[widget.index % AppGradients.cardGradients.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Get.dialog(
            ProjectDetailsDialog(project: widget.project),
            barrierColor: Colors.black.withOpacity(0.8),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -10))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E28), // Dark card background
            borderRadius: BorderRadius.circular(15),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Gradient Section
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: _buildProjectIcon(),
                ),
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Description
                    Text(
                      widget.project.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 20),

                    // Tech Stack Labels
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.techStack.take(3).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectIcon() {
    // If image is a local asset path, we can still use it, but maybe smaller
    // For now, let's use a generic icon map based on tech stack or title
    IconData iconData = FontAwesomeIcons.code;

    // Simple heuristic for icons
    final title = widget.project.title.toLowerCase();
    if (title.contains('app') || title.contains('flutter')) {
      iconData = FontAwesomeIcons.mobileScreen;
    } else if (title.contains('web') || title.contains('portfolio')) {
      iconData = FontAwesomeIcons.globe;
    } else if (title.contains('api') || title.contains('server')) {
      iconData = FontAwesomeIcons.server;
    } else if (title.contains('game')) {
      iconData = FontAwesomeIcons.gamepad;
    } else if (title.contains('tool') || title.contains('extension')) {
      iconData = FontAwesomeIcons.screwdriverWrench;
    }

    // Reference images show a specific icon or image in the center.
    // If the user has images, we could box them nicely.
    // Let's try to use the image field if it looks like an icon, otherwise fallback to FontAwesome

    // Assuming existing images are screenshots, we might want to prioritize icons for this specific look
    // Or display the screenshot in a small rounded box.

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(iconData, color: Colors.white, size: 30),
    );
  }
}
