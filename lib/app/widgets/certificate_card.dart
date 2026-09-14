import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/models/certificate.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import 'certificate_modal.dart';

class CertificateCard extends StatefulWidget {
  final Certificate certificate;
  const CertificateCard({Key? key, required this.certificate})
      : super(key: key);

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
  bool _isHovered = false;

  void _showModal() {
    showDialog(
      context: context,
      builder: (context) => CertificateModal(certificate: widget.certificate),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cert = widget.certificate;
    final isPdf = cert.format == 'pdf';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _showModal,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -6))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.6)
                  : Colors.white.withOpacity(0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                blurRadius: _isHovered ? 18 : 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Thumbnail / PDF banner
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF161622),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: isPdf
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (bounds) => AppGradients
                                            .primary
                                            .createShader(bounds),
                                        child: const FaIcon(
                                          FontAwesomeIcons.filePdf,
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'PDF Document',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Image.asset(
                                  cert.filePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) {
                                    return const Center(
                                      child: Icon(
                                        Icons.workspace_premium,
                                        size: 45,
                                        color: Colors.white38,
                                      ),
                                    );
                                  },
                                ),
                        ),
                        // Top Category Badge
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Text(
                              cert.category,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Card Information Footer
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cert.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cert.issuer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (cert.year != null)
                            Text(
                              cert.year!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white38,
                              ),
                            )
                          else
                            const SizedBox(),
                          Row(
                            children: [
                              Text(
                                "View",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
