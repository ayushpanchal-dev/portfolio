import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/models/project.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_helper.dart';

class ProjectDetailsDialog extends StatelessWidget {
  final Project project;

  const ProjectDetailsDialog({Key? key, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    final double dialogWidth =
        isMobile ? MediaQuery.of(context).size.width * 0.9 : 600;

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: dialogWidth,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with Title and Close Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Project Image
              if (project.image.isNotEmpty)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    image: DecorationImage(
                      image: project.image.startsWith('http')
                          ? NetworkImage(project.image)
                          : AssetImage(project.image) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meta Info (Year & Type)
                    Row(
                      children: [
                        if (project.year != null) ...[
                          const Icon(Icons.calendar_today_outlined,
                              color: Colors.white60, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            project.year!,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(width: 24),
                        ],
                        if (project.type != null) ...[
                          const Icon(Icons.code,
                              color: Colors.white60, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            project.type!,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Actions (GitHub / Live) - Placeholder only if needed, user didn't explicitly ask for buttons inside dialog in prompt, but image had them. I'll omit for now or add structured plain text/icons as requested by "I will add details...".
                    // The user image had buttons. I'll add them if data exists, or just placeholders.
                    // For now, let's stick to the prompt structure: About, Features, Tech Stack.

                    // About This Project
                    if (project.about != null ||
                        project.description.isNotEmpty) ...[
                      Text(
                        'About This Project',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project.about ?? project.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],

                    // Key Features
                    if (project.features != null &&
                        project.features!.isNotEmpty) ...[
                      Text(
                        'Key Features',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.features!.map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 30),
                    ],

                    // Technology Stack
                    Text(
                      'Technology Stack',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: project.techStack
                          .map((tech) => _buildTechIcon(tech))
                          .toList(),
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

  Widget _buildTechIcon(String tech) {
    IconData iconData;
    Color color = Colors.white;

    // Simple mapping for demo purposes. Can be expanded.
    final t = tech.toLowerCase();
    if (t.contains('flutter')) {
      iconData = FontAwesomeIcons.flutter; // Corrected icon access
      color = const Color(0xFF02569B);
    } else if (t.contains('dart')) {
      iconData = FontAwesomeIcons.bullseye; // Use a distinct icon for Dart
      color = const Color(0xFF0175C2);
    } else if (t.contains('firebase')) {
      iconData = FontAwesomeIcons.fire;
      color = const Color(0xFFFFCA28);
    } else if (t.contains('python') || t.contains('django')) {
      iconData = FontAwesomeIcons.python;
      color = const Color(0xFF3776AB);
    } else if (t.contains('react')) {
      iconData = FontAwesomeIcons.react;
      color = const Color(0xFF61DAFB);
    } else if (t.contains('html')) {
      iconData = FontAwesomeIcons.html5;
      color = const Color(0xFFE34F26);
    } else if (t.contains('css')) {
      iconData = FontAwesomeIcons.css3;
      color = const Color(0xFF1572B6);
    } else if (t.contains('js') || t.contains('javascript')) {
      iconData = FontAwesomeIcons.js;
      color = const Color(0xFFF7DF1E);
    } else if (t.contains('android')) {
      iconData = FontAwesomeIcons.android;
      color = const Color(0xFF3DDC84);
    } else if (t.contains('apple') || t.contains('ios')) {
      iconData = FontAwesomeIcons.apple;
    } else if (t.contains('github') || t.contains('git')) {
      iconData = FontAwesomeIcons.github;
    } else {
      iconData = Icons.code;
    }

    return Tooltip(
      message: tech,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(iconData, color: color, size: 24),
      ),
    );
  }
}
