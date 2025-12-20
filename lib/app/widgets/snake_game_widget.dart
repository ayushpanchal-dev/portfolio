import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SnakeGameWidget extends StatefulWidget {
  const SnakeGameWidget({Key? key}) : super(key: key);

  @override
  _SnakeGameWidgetState createState() => _SnakeGameWidgetState();
}

enum Direction { up, down, left, right }

class Skill {
  final String name;
  final IconData icon;
  final Color color;

  Skill(this.name, this.icon, this.color);
}

class _SnakeGameWidgetState extends State<SnakeGameWidget> {
  final int _squaresPerRow = 15;
  final int _squaresPerCol = 25;
  late int _totalSquares;
  List<int> _snake = [];
  int _foodPosition = 0;
  int _currentSkillIndex = 0;
  Direction _direction = Direction.down;
  bool _isPlaying = false;
  Timer? _timer;
  int _score = 0;
  final FocusNode _focusNode = FocusNode();

  // Modern Color Palette
  final Color _backgroundColor = const Color(0xFF011627); // Deep Blue
  final Color _boardColor = const Color(0xFF0B253A); // Slightly lighter blue
  final Color _snakeHeadColor = const Color(0xFF4D5BCE); // Cyan/Blue accent
  final Color _snakeBodyColor = const Color(0xFF43D9AD); // Greenish Cyan

  final List<Skill> _skills = [
    Skill('Flutter', FontAwesomeIcons.flutter, const Color(0xFF02569B)),
    Skill('Dart', FontAwesomeIcons.bullseye, const Color(0xFF0175C2)),
    Skill('Firebase', FontAwesomeIcons.fire, const Color(0xFFFFCA28)),
    Skill('Python', FontAwesomeIcons.python, const Color(0xFF3776AB)),
    Skill('React', FontAwesomeIcons.react, const Color(0xFF61DAFB)),
    Skill('Git', FontAwesomeIcons.github, const Color(0xFFF05133)),
    Skill('Android', FontAwesomeIcons.android, const Color(0xFF3DDC84)),
    Skill('HTML', FontAwesomeIcons.html5, const Color(0xFFE34F26)),
    Skill('CSS', FontAwesomeIcons.css3, const Color(0xFF1572B6)),
    Skill('JS', FontAwesomeIcons.js, const Color(0xFFF7DF1E)),
  ];

  @override
  void initState() {
    super.initState();
    _totalSquares = _squaresPerRow * _squaresPerCol;
    _resetGame();
  }

  void _resetGame() {
    _timer?.cancel();
    setState(() {
      // Start in middle
      int start = (_totalSquares / 2).floor();
      _snake = [start, start + _squaresPerRow, start + 2 * _squaresPerRow];
      _direction = Direction.up;
      _score = 0;
      _currentSkillIndex = 0;
      _isPlaying = false;
      _generateFood();
    });
  }

  void _generateFood() {
    final random = Random();
    do {
      _foodPosition = random.nextInt(_totalSquares);
    } while (_snake.contains(_foodPosition));

    // Cycle through skills or pick random
    // _currentSkillIndex = random.nextInt(_skills.length);
    _currentSkillIndex = (_currentSkillIndex + 1) % _skills.length;
  }

  void _startGame() {
    setState(() {
      _isPlaying = true;
      _score = 0;
      _resetGame(); // Ensure fresh start
      _direction = Direction.up;
      _isPlaying = true; // Reset explicit
    });
    // Slower speed (300ms)
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      _moveSnake();
    });
    _focusNode.requestFocus();
  }

  void _moveSnake() {
    setState(() {
      int newHead;
      switch (_direction) {
        case Direction.up:
          newHead = _snake.first - _squaresPerRow;
          if (newHead < 0) {
            _gameOver();
            return;
          }
          break;
        case Direction.down:
          newHead = _snake.first + _squaresPerRow;
          if (newHead >= _totalSquares) {
            _gameOver();
            return;
          }
          break;
        case Direction.left:
          if (_snake.first % _squaresPerRow == 0) {
            _gameOver();
            return;
          } else {
            newHead = _snake.first - 1;
          }
          break;
        case Direction.right:
          if ((_snake.first + 1) % _squaresPerRow == 0) {
            _gameOver();
            return;
          } else {
            newHead = _snake.first + 1;
          }
          break;
      }

      if (_snake.contains(newHead)) {
        _gameOver();
        return;
      }

      _snake.insert(0, newHead);
      if (_snake.first == _foodPosition) {
        _score++;
        _generateFood();
      } else {
        _snake.removeLast();
      }
    });
  }

  void _gameOver() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
          _direction != Direction.down) {
        _direction = Direction.up;
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
          _direction != Direction.up) {
        _direction = Direction.down;
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
          _direction != Direction.right) {
        _direction = Direction.left;
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          _direction != Direction.left) {
        _direction = Direction.right;
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black54, width: 8), // Screws view
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Background visual elements (Screws)
                Positioned(top: 10, left: 10, child: _buildScrew()),
                Positioned(top: 10, right: 10, child: _buildScrew()),
                Positioned(bottom: 10, left: 10, child: _buildScrew()),
                Positioned(bottom: 10, right: 10, child: _buildScrew()),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AspectRatio(
                    aspectRatio: _squaresPerRow / _squaresPerCol,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _boardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Focus(
                        focusNode: _focusNode,
                        onKey: _handleKeyEvent,
                        autofocus: true,
                        child: Stack(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _totalSquares,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _squaresPerRow,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),
                              itemBuilder: (context, index) {
                                if (_snake.contains(index)) {
                                  // Snake Gradient
                                  double opacity = 1.0 -
                                      (_snake.indexOf(index) / _snake.length) *
                                          0.6;
                                  return Container(
                                    decoration: BoxDecoration(
                                      color:
                                          _snakeBodyColor.withOpacity(opacity),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: index == _snake.first
                                          ? [
                                              BoxShadow(
                                                color: _snakeHeadColor
                                                    .withOpacity(0.6),
                                                blurRadius: 8,
                                                spreadRadius: 2,
                                              )
                                            ]
                                          : [],
                                    ),
                                  );
                                } else if (index == _foodPosition) {
                                  // Render Skill Icon
                                  return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _skills[_currentSkillIndex]
                                          .color
                                          .withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: _skills[_currentSkillIndex]
                                              .color
                                              .withOpacity(0.5),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: FaIcon(
                                      _skills[_currentSkillIndex].icon,
                                      size: 14, // Small icon size for grid
                                      color: _skills[_currentSkillIndex].color,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  );
                                }
                              },
                            ),
                            // Score / Skill Display
                            Positioned(
                              top: 10,
                              right: 20,
                              left: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Score: $_score',
                                    style: GoogleFonts.firaCode(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                  // Show Next Target even when not playing for visuals
                                  Text(
                                    _isPlaying
                                        ? 'Target: ${_skills[_currentSkillIndex].name}'
                                        : (_score > 0 ? 'Game Over' : ''),
                                    style: GoogleFonts.firaCode(
                                      color: _skills[_currentSkillIndex].color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Start Game Overlay
                if (!_isPlaying)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _score > 0 ? 'Game Over' : 'Snake Skills',
                            style: GoogleFonts.firaCode(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: _score > 0
                                  ? Colors.redAccent
                                  : _snakeBodyColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Collect skills to score!',
                            style: GoogleFonts.firaCode(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _startGame,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEA55F),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'start-game',
                              style: GoogleFonts.firaCode(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScrew() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2D3D),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 0,
            offset: const Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 1,
            spreadRadius: 0,
            offset: const Offset(-1, -1),
          ),
        ],
      ),
      child: Center(
        child: Icon(Icons.close, size: 8, color: Colors.black54),
      ),
    );
  }
}
