import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models/project.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'gradient_text.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = loadProjects();
  }

  Future<List<Project>> loadProjects() async {
    final String response = await rootBundle.loadString('assets/projects.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Project.fromJson(json)).toList();
  }

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
            'Projects',
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
          FutureBuilder<List<Project>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading projects',
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No projects found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final projects = snapshot.data!;

              return isMobile
                  ? Column(
                      children: projects.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ProjectCard(
                            project: entry.value,
                            index: entry.key,
                          ),
                        );
                      }).toList(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio:
                            1.1, // Adjusted to reduce card height and empty space
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                      ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return ProjectCard(
                          project: projects[index],
                          index: index,
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
