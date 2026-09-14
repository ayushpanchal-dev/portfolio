import 'dart:math' as math;
import 'package:flutter/material.dart';

class DeveloperBackgroundWidget extends StatefulWidget {
  final Widget child;
  const DeveloperBackgroundWidget({Key? key, required this.child})
      : super(key: key);

  @override
  State<DeveloperBackgroundWidget> createState() =>
      _DeveloperBackgroundWidgetState();
}

class _DeveloperBackgroundWidgetState extends State<DeveloperBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _DeveloperCanvasPainter(progress: _controller.value),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _DeveloperCanvasPainter extends CustomPainter {
  final double progress;
  _DeveloperCanvasPainter({required this.progress});

  static final List<String> _codeLines = [
    'class MyApp extends StatelessWidget {',
    '  Widget build(BuildContext context) {',
    '    return GetMaterialApp(',
    '      theme: ThemeData.dark(),',
    '      home: const HomeView(),',
    '    );',
    '  }',
    '}',
    'final dio = Dio(BaseOptions(baseUrl: api));',
    'Get.to(() => const DetailView());',
    'final response = await dio.get("/sales/crm");',
    'PlutoGrid(columns: cols, rows: rows)',
    'SyncfusionDataGrid(source: dataSource)',
    'final state = Get.find<SalesController>();',
    'class FieldSalesCRM extends StatefulWidget {',
    '  final String routeId;',
    '  final LatLng gpsCoordinates;',
    '}',
    'StreamBuilder<QuerySnapshot>(',
    '  builder: (ctx, snap) => ListView(...),',
    ')',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Draw dark radial gradient background
    final bgRect = Rect.fromLTWH(0, 0, width, height);
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.4, -0.3),
        radius: 1.2,
        colors: [
          const Color(0xFF1E1B4B).withOpacity(0.9), // Deep indigo
          const Color(0xFF0F0D24), // Dark background
        ],
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // Draw subtle animated grid background
    final gridPaint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.04)
      ..strokeWidth = 1.0;

    const double gridSpacing = 60.0;
    final double offsetY = (progress * gridSpacing) % gridSpacing;

    for (double x = 0; x < width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, height), gridPaint);
    }
    for (double y = offsetY; y < height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(width, y), gridPaint);
    }

    // Draw floating code lines
    final textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF818CF8).withOpacity(0.12),
    );

    final random = math.Random(42); // Fixed seed for stable positions

    for (int i = 0; i < _codeLines.length; i++) {
      final code = _codeLines[i];
      final baseX = (random.nextDouble() * (width - 200)).clamp(20.0, width - 300);
      final initialY = random.nextDouble() * height;
      // Drift upwards continuously
      final currentY = (initialY - progress * height * 0.4) % height;
      final displayY = currentY < 0 ? currentY + height : currentY;

      final textSpan = TextSpan(text: code, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(baseX, displayY));
    }

    // Draw glowing node dots and connections
    final nodePaint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = const Color(0xFF818CF8).withOpacity(0.08)
      ..strokeWidth = 1.0;

    final List<Offset> nodes = [];
    for (int i = 0; i < 12; i++) {
      final nx = (random.nextDouble() * width);
      final ny = (random.nextDouble() * height + math.sin(progress * 2 * math.pi + i) * 30) % height;
      nodes.add(Offset(nx, ny));
      canvas.drawCircle(Offset(nx, ny), 3.0 + (i % 3), nodePaint);
    }

    // Connect close nodes
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final dist = (nodes[i] - nodes[j]).distance;
        if (dist < 200) {
          canvas.drawLine(nodes[i], nodes[j], linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DeveloperCanvasPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
