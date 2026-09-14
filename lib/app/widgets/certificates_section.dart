import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models/certificate.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../utils/responsive_helper.dart';
import 'certificate_card.dart';
import 'gradient_text.dart';

class CertificatesSection extends StatefulWidget {
  const CertificatesSection({Key? key}) : super(key: key);

  @override
  State<CertificatesSection> createState() => _CertificatesSectionState();
}

class _CertificatesSectionState extends State<CertificatesSection> {
  late Future<List<Certificate>> _certificatesFuture;
  String _selectedCategory = 'All';
  bool _showAll = false;

  final List<String> _categories = [
    'All',
    'Flutter & Mobile',
    'Programming & Web',
    'AI & Tools',
    'Achievements',
  ];

  static final List<Certificate> _fallbackCertificates = [
    Certificate(
      id: "c1",
      title: "Flutter Development Certificate",
      issuer: "Alison",
      category: "Flutter & Mobile",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/alison_flutter.png",
      year: "2024",
    ),
    Certificate(
      id: "c2",
      title: "Flutter for Beginners",
      issuer: "Great Learning",
      category: "Flutter & Mobile",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/gl_flutter.jpg",
      year: "2024",
    ),
    Certificate(
      id: "c3",
      title: "Flutter Certificate Course",
      issuer: "Simplilearn",
      category: "Flutter & Mobile",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/flutter_simplilearn.png",
      year: "2024",
    ),
    Certificate(
      id: "c4",
      title: "Programming Foundations: Beyond the Fundamentals",
      issuer: "LinkedIn Learning / NASBA",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/programming_foundations.png",
      year: "2023",
    ),
    Certificate(
      id: "c5",
      title: "Problem Solving (Basic)",
      issuer: "HackerRank",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/hackerrank_problem_solving.png",
      year: "2023",
    ),
    Certificate(
      id: "c6",
      title: "HTML & CSS Web Development",
      issuer: "TOPS Technologies",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/tops_html_css.png",
      year: "2022",
    ),
    Certificate(
      id: "c7",
      title: "UI/UX Design for Beginners",
      issuer: "Great Learning",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/gl_uiux.jpg",
      year: "2024",
    ),
    Certificate(
      id: "c8",
      title: "Python Fundamentals",
      issuer: "Great Learning",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/gl_python.jpg",
      year: "2023",
    ),
    Certificate(
      id: "c9",
      title: "Complete Python Bootcamp",
      issuer: "Udemy",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/udemy_python.png",
      year: "2023",
    ),
    Certificate(
      id: "c10",
      title: "Java & C++ Programming",
      issuer: "Udemy",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/udemy_java_cpp.png",
      year: "2022",
    ),
    Certificate(
      id: "c11",
      title: "C & C++ Certification",
      issuer: "Technical Institute",
      category: "Programming & Web",
      priority: "high",
      format: "image",
      filePath: "assets/certificates/c_cpp_certificate.jpeg",
      year: "2021",
    ),
    Certificate(
      id: "c12",
      title: "ChatGPT for Beginners",
      issuer: "Great Learning",
      category: "AI & Tools",
      priority: "medium",
      format: "image",
      filePath: "assets/certificates/gl_chatgpt.jpg",
      year: "2024",
    ),
    Certificate(
      id: "c13",
      title: "E-Commerce Fundamentals",
      issuer: "ATINGI",
      category: "AI & Tools",
      priority: "medium",
      format: "image",
      filePath: "assets/certificates/atingi_ecommerce.png",
      year: "2023",
    ),
    Certificate(
      id: "c14",
      title: "Human Resource Management",
      issuer: "Saylor Academy",
      category: "Achievements",
      priority: "low",
      format: "image",
      filePath: "assets/certificates/hrm_saylor.png",
      year: "2023",
    ),
    Certificate(
      id: "c15",
      title: "Participation & Recognition",
      issuer: "Aaj Tak",
      category: "Achievements",
      priority: "low",
      format: "image",
      filePath: "assets/certificates/aajtak.png",
      year: "2023",
    ),
    Certificate(
      id: "c16",
      title: "GEMI Training Certificate",
      issuer: "GEMI",
      category: "Achievements",
      priority: "low",
      format: "image",
      filePath: "assets/certificates/gemi_certificate.jpeg",
      year: "2023",
    ),
    Certificate(
      id: "c17",
      title: "Life Skill Program",
      issuer: "Life Skills Education",
      category: "Achievements",
      priority: "low",
      format: "image",
      filePath: "assets/certificates/life_skill.jpeg",
      year: "2022",
    ),
    Certificate(
      id: "c18",
      title: "Teacher's Day Recognition",
      issuer: "Institutional Award",
      category: "Achievements",
      priority: "low",
      format: "image",
      filePath: "assets/certificates/teachers_day.jpeg",
      year: "2022",
    ),
    Certificate(
      id: "c19",
      title: "Krida Bharti Certificate",
      issuer: "Krida Bharti",
      category: "Achievements",
      priority: "low",
      format: "image",
      filePath: "assets/certificates/krida_bharti.jpeg",
      year: "2021",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _certificatesFuture = _loadCertificates();
  }

  Future<List<Certificate>> _loadCertificates() async {
    try {
      final String response =
          await rootBundle.loadString('assets/certificates.json');
      final List<dynamic> data = json.decode(response);
      final certs = data.map((json) => Certificate.fromJson(json)).toList();

      certs.sort((a, b) {
        final pMap = {'high': 0, 'medium': 1, 'low': 2};
        final pA = pMap[a.priority] ?? 1;
        final pB = pMap[b.priority] ?? 1;
        return pA.compareTo(pB);
      });

      return certs;
    } catch (e) {
      // Fallback seamlessly if rootBundle asset loading fails
      final certs = List<Certificate>.from(_fallbackCertificates);
      certs.sort((a, b) {
        final pMap = {'high': 0, 'medium': 1, 'low': 2};
        final pA = pMap[a.priority] ?? 1;
        final pB = pMap[b.priority] ?? 1;
        return pA.compareTo(pB);
      });
      return certs;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 60,
      ),
      child: Column(
        children: [
          GradientText(
            'Certificates & Achievements',
            gradient: AppGradients.primary,
            style: GoogleFonts.rubik(
              fontSize: isMobile ? 30 : 40,
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
            "Verified technical certifications, professional training, and achievements",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 35),

          // Category Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: FilterChip(
                    label: Text(
                      cat,
                      style: GoogleFonts.poppins(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
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

          // Certificate Cards Grid
          FutureBuilder<List<Certificate>>(
            future: _certificatesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No certificates found."));
              }

              final filteredCerts = snapshot.data!.where((cert) {
                if (_selectedCategory == 'All') return true;
                return cert.category == _selectedCategory;
              }).toList();

              if (filteredCerts.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "No certificates under '$_selectedCategory'",
                    style: GoogleFonts.poppins(color: Colors.white70),
                  ),
                );
              }

              final displayedCerts = (_showAll || filteredCerts.length <= 6)
                  ? filteredCerts
                  : filteredCerts.take(6).toList();

              return Column(
                children: [
                  isDesktop
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.1,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                          ),
                          itemCount: displayedCerts.length,
                          itemBuilder: (context, index) {
                            return CertificateCard(
                                certificate: displayedCerts[index]);
                          },
                        )
                      : isMobile
                          ? Column(
                              children: displayedCerts.map((cert) {
                                return Container(
                                  height: 280,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: CertificateCard(certificate: cert),
                                );
                              }).toList(),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: displayedCerts.length,
                              itemBuilder: (context, index) {
                                return CertificateCard(
                                    certificate: displayedCerts[index]);
                              },
                            ),
                  if (filteredCerts.length > 6) ...[
                    const SizedBox(height: 35),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _showAll = !_showAll;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF0072FF), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: Text(
                        _showAll
                            ? "Show Less"
                            : "Show All Certificates (${filteredCerts.length})",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
