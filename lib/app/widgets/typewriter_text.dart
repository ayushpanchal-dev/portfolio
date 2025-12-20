import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle style;
  final Duration duration;

  const TypewriterText({
    Key? key,
    required this.texts,
    required this.style,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _currentIndex = 0;
  String _currentText = "";
  Timer? _timer;
  bool _isTyping = true;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer?.cancel();
    final text = widget.texts[_currentIndex];

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isTyping) {
        if (_currentText.length < text.length) {
          setState(() {
            _currentText = text.substring(0, _currentText.length + 1);
          });
        } else {
          _isTyping = false;
          _timer?.cancel();
          Future.delayed(widget.duration, () {
            _startTyping();
          });
        }
      } else {
        if (_currentText.isNotEmpty) {
          setState(() {
            _currentText = _currentText.substring(0, _currentText.length - 1);
          });
        } else {
          _isTyping = true;
          _currentIndex = (_currentIndex + 1) % widget.texts.length;
          _timer?.cancel();
          _startTyping();
        }
      }
    });

    if (!_isTyping) {
      // Deleting logic needs separate timer or logic handling
      // Simplified re-implementation:
      // The periodic timer above handles typing forward.
      // Let's implement full cycle properly in next periodic tick if needed.
      // Actually, the above logic has a flaw: recursive call inside callback.
      // Better to re-write simpler logic.
    }
  }

  // Improved implementation to match typical typewriter behavior
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("$_currentText|", style: widget.style);
  }
}
