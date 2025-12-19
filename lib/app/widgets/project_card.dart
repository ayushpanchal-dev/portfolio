import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this import
import '../data/models/project.dart';
import '../theme/app_colors.dart';
import 'project_details_dialog.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
            color: AppColors.surface,
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
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.black12,
                  child: widget.project.image.startsWith('http')
                      ? Image.network(
                          widget.project.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image,
                                  color: Colors.white),
                        )
                      : Image.asset(
                          widget.project.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image,
                                  color: Colors.white),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.project.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        ...widget.project.techStack
                            .take(5)
                            .map((tech) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: _buildSmallTechIcon(tech),
                                )),
                        if (widget.project.techStack.length > 5)
                          Text(
                            '+${widget.project.techStack.length - 5}',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12),
                          ),
                      ],
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

  Widget _buildSmallTechIcon(String tech) {
    IconData iconData;
    Color color = Colors.white70;

    final t = tech.toLowerCase();
    if (t.contains('flutter')) {
      iconData = FontAwesomeIcons.flutter;
    } else if (t.contains('dart')) {
      iconData = FontAwesomeIcons.bullseye;
    } else if (t.contains('firebase')) {
      iconData = FontAwesomeIcons.fire;
    } else if (t.contains('python') || t.contains('django')) {
      iconData = FontAwesomeIcons.python;
    } else if (t.contains('react')) {
      iconData = FontAwesomeIcons.react;
    } else {
      iconData = Icons.code;
    }

    return Icon(iconData, size: 16, color: color);
  }
}
