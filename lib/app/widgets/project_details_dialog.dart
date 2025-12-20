import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/models/project.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';

class ProjectDetailsDialog extends StatelessWidget {
  final Project project;

  const ProjectDetailsDialog({Key? key, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    final double dialogWidth =
        isMobile ? MediaQuery.of(context).size.width * 0.9 : 700;

    return Dialog(
      backgroundColor: Colors.transparent, // Transparent for custom container
      insetPadding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          width: dialogWidth,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface, // Base dark color
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Image Section
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: project.image.isNotEmpty
                              ? DecorationImage(
                                  image: project.image.startsWith('http')
                                      ? NetworkImage(project.image)
                                      : AssetImage(project.image)
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: AppColors.background,
                        ),
                        // Dark overlay for text readability
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.surface.withOpacity(0.8),
                                AppColors.surface,
                              ],
                              stops: const [0.0, 0.7, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.black45,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 24,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              project.title,
                              gradient: AppGradients.primary,
                              style: GoogleFonts.rubik(
                                fontSize: isMobile ? 28 : 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (project.type != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color:
                                          AppColors.primary.withOpacity(0.3)),
                                ),
                                child: Text(
                                  project.type!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Content Section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Section
                        if (project.about != null ||
                            project.description.isNotEmpty) ...[
                          Text(
                            'About Project',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            project.about ?? project.description,
                            style: const TextStyle(
                              color: Colors.white70,
                              height: 1.6,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Tech Stack
                        Text(
                          'Tech Stack',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: project.techStack
                              .map((tech) => _buildTechBadge(tech))
                              .toList(),
                        ),
                        const SizedBox(height: 24),

                        // Key Features
                        if (project.features != null &&
                            project.features!.isNotEmpty) ...[
                          Text(
                            'Key Features',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Column(
                              children: project.features!.map((feature) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (bounds) =>
                                              AppGradients.primary
                                                  .createShader(bounds),
                                          child: const Icon(
                                              Icons.check_circle_outline,
                                              size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            height: 1.5,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechBadge(String tech) {
    IconData iconData = _getIconForTech(tech);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(iconData, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Text(
            tech,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTech(String tech) {
    final t = tech.toLowerCase();
    if (t.contains('flutter')) return FontAwesomeIcons.flutter;
    if (t.contains('dart')) return FontAwesomeIcons.bullseye;
    if (t.contains('firebase')) return FontAwesomeIcons.fire;
    if (t.contains('python')) return FontAwesomeIcons.python;
    if (t.contains('react')) return FontAwesomeIcons.react;
    if (t.contains('html')) return FontAwesomeIcons.html5;
    if (t.contains('css')) return FontAwesomeIcons.css3;
    if (t.contains('js') || t.contains('javascript'))
      return FontAwesomeIcons.js;
    if (t.contains('android')) return FontAwesomeIcons.android;
    if (t.contains('ios') || t.contains('apple')) return FontAwesomeIcons.apple;
    if (t.contains('git')) return FontAwesomeIcons.github;
    return Icons.code;
  }
}
