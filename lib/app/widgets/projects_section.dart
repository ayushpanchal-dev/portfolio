import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models/project.dart';
import '../theme/app_colors.dart';
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
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Professional Projects',
    'Personal Showcase',
  ];

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
    final isDesktop = ResponsiveHelper.isDesktop(context);

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
          const SizedBox(height: 16),
          Text(
            "Enterprise applications developed professionally & personal projects showcased on ScreenCraft AI",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 35),

          // Non-clipping Category Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: FilterChip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        cat,
                        style: GoogleFonts.poppins(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w400,
                        ),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                    backgroundColor: Colors.white.withOpacity(0.04),
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 40),

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

              final allProjects = snapshot.data!;
              final filteredProjects = allProjects.where((p) {
                if (_selectedCategory == 'Professional Projects') {
                  return p.category == 'professional';
                } else if (_selectedCategory == 'Personal Showcase') {
                  return p.category == 'personal';
                }
                return true;
              }).toList();

              if (filteredProjects.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "No projects under '$_selectedCategory'",
                    style: GoogleFonts.poppins(color: Colors.white70),
                  ),
                );
              }

              return isMobile
                  ? Column(
                      children: filteredProjects.asMap().entries.map((entry) {
                        return Container(
                          height: 380,
                          margin: const EdgeInsets.only(bottom: 30),
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
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 2,
                        childAspectRatio: isDesktop ? 1.05 : 0.95,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                      ),
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        return ProjectCard(
                          project: filteredProjects[index],
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
