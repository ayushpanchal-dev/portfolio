import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/certificate.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_gradients.dart';
import '../../../utils/responsive_helper.dart';
import '../../../widgets/certificate_card.dart';
import '../../../widgets/footer.dart';
import '../../../widgets/gradient_text.dart';

class AllCertificatesView extends StatefulWidget {
  const AllCertificatesView({Key? key}) : super(key: key);

  @override
  State<AllCertificatesView> createState() => _AllCertificatesViewState();
}

class _AllCertificatesViewState extends State<AllCertificatesView> {
  late Future<List<Certificate>> _certificatesFuture;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Flutter & Mobile',
    'Programming & Web',
    'AI & Tools',
    'Achievements',
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
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Bar with Back Button & Portfolio Branding
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 40,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Get.back();
                        } else {
                          Get.offAllNamed('/');
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Back to Home',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/profile_ayush.jpg',
                            height: 36,
                            width: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (!isMobile)
                          Text(
                            'AYUSH PANCHAL',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Section Content
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 100,
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    GradientText(
                      'Certificates & Achievements',
                      gradient: AppGradients.primary,
                      textAlign: TextAlign.center,
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
                      "Complete collection of verified technical certifications, professional training, and honors",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 35),

                    // Non-clipping Category Filter Chips
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  cat,
                                  style: GoogleFonts.poppins(
                                    color:
                                        isSelected ? Colors.white : Colors.white70,
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w400,
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

                    // Certificates Grid
                    FutureBuilder<List<Certificate>>(
                      future: _certificatesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Text(
                                "No certificates found.",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          );
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
                              style:
                                  GoogleFonts.poppins(color: Colors.white70),
                            ),
                          );
                        }

                        return isMobile
                            ? Column(
                                children: filteredCerts.map((cert) {
                                  return Container(
                                    height: 290,
                                    margin: const EdgeInsets.only(bottom: 24),
                                    child: CertificateCard(certificate: cert),
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
                                itemCount: filteredCerts.length,
                                itemBuilder: (context, index) {
                                  return CertificateCard(
                                    certificate: filteredCerts[index],
                                  );
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),

              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
