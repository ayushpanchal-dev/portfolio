import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  late PageController _pageController;
  int _currentPageIndex = 0;

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
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _certificatesFuture = _loadCertificates();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      return List<Certificate>.from(_fallbackCertificates);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    // Cards per page: Desktop 3, Tablet 2, Mobile 1
    final cardsPerPage = isDesktop ? 3 : (isMobile ? 1 : 2);

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
            "Featured verified technical certifications and achievements",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 40),

          // Featured Carousel Container
          FutureBuilder<List<Certificate>>(
            future: _certificatesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No certificates found.",
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              final allCerts = snapshot.data!;
              // Featured subset for carousel
              final featuredCerts = allCerts.take(8).toList();

              // Calculate total pages
              final totalPages = (featuredCerts.length / cardsPerPage).ceil();

              return Column(
                children: [
                  // Carousel Slider Row with Navigation Arrows
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: isMobile ? 300 : 320,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: totalPages,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                          itemBuilder: (context, pageIndex) {
                            final startIndex = pageIndex * cardsPerPage;
                            final endIndex = (startIndex + cardsPerPage <=
                                    featuredCerts.length)
                                ? startIndex + cardsPerPage
                                : featuredCerts.length;
                            final pageItems =
                                featuredCerts.sublist(startIndex, endIndex);

                            return Row(
                              children: pageItems.map((cert) {
                                return Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    child: CertificateCard(certificate: cert),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),

                      // Left Arrow (Desktop / Tablet)
                      if (!isMobile && _currentPageIndex > 0)
                        Positioned(
                          left: 0,
                          child: IconButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),

                      // Right Arrow (Desktop / Tablet)
                      if (!isMobile && _currentPageIndex < totalPages - 1)
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Carousel Page Indicator Dots
                  if (totalPages > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalPages, (index) {
                        final isSelected = _currentPageIndex == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: isSelected ? 24 : 8,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  const SizedBox(height: 35),

                  // View All Certificates Button
                  OutlinedButton.icon(
                    onPressed: () {
                      Get.toNamed('/certificates');
                    },
                    icon: const Icon(
                      Icons.workspace_premium_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      "View All Certificates (${allCerts.length}) →",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFF0072FF), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor: Colors.white.withOpacity(0.02),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
