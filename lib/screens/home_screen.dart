import 'dart:math';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../widgets/grid_painter.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgCtrl;
  late Animation<double> _bgAnim;
  int _selectedSize = 3;
  bool _showHowTo = false;

  @override
  void initState() {
    super.initState();
    _bgCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
    _bgAnim =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _bgCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgAnim,
        builder: (_, __) => Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(
                  0.3 * sin(_bgAnim.value * pi),
                  -0.3 * cos(_bgAnim.value * pi),
                ),
                radius: 1.5,
                colors: const [Color(0xFF1A0533), Color(0xFF0D1B3E), AppColors.backgroundColor],
              ),
            ),
          ),
          ...List.generate(5, _buildOrb),
          CustomPaint(size: Size.infinite, painter: GridPainter()),
          SafeArea(
            child: _showHowTo ? _buildHowToPage() : _buildHome(),
          ),
        ]),
      ),
    );
  }

  Widget _buildHome() {
    return Column(children: [
      const SizedBox(height: 50),
      _buildTitle(),
      const SizedBox(height: 40),
      _buildPreview(),
      const SizedBox(height: 36),
      _buildSizeSelector(),
      const Spacer(),
      _buildPlayBtn(),
      const SizedBox(height: 14),
      _buildHowToBtn(),
      const SizedBox(height: 40),
    ]);
  }

  Widget _buildOrb(int i) {
    final pos = [[0.1, 0.1],[0.9, 0.15],[0.05, 0.5],[0.95, 0.6],[0.5, 0.9]];
    final cols = [
      AppColors.primaryColor, AppColors.secondaryColor,
      AppColors.accentColor, AppColors.successColor, const Color(0xFFD97706),
    ];
    final sz = [120.0, 80.0, 100.0, 90.0, 110.0][i];
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Positioned(
      left: w * pos[i][0] - sz / 2,
      top: h * pos[i][1] - sz / 2,
      child: Container(
        width: sz, height: sz,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            cols[i].withOpacity(0.35),
            cols[i].withOpacity(0),
          ]),
        ),
      ),
    );
  }

  Widget _buildTitle() => Column(children: [
    ShaderMask(
      shaderCallback: (b) => const LinearGradient(
        colors: [Color(0xFFA78BFA), Color(0xFF60A5FA), Color(0xFFF472B6)],
      ).createShader(b),
      child: const Text('PUZZLE',
          style: AppTextStyles.titleStyle),
    ),
    const Text('E N I G M A',
        style: AppTextStyles.subtitleStyle),
  ]);

  Widget _buildPreview() {
    return Container(
      width: 110, height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
        boxShadow: [BoxShadow(
          color: AppColors.primaryColor.withOpacity(0.5),
          blurRadius: 30, spreadRadius: 5,
        )],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4, crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(9, (i) {
              if (i == 8) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black.withOpacity(0.3),
                  ),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1 + i * 0.04),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text('${i + 1}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Column(children: [
      const Text('SELECT GRID SIZE',
          style: TextStyle(
            color: AppColors.textLightColor, fontSize: 11,
            letterSpacing: 4, fontWeight: FontWeight.w600,
          )),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [3, 4, 5].map((size) {
          final sel = _selectedSize == size;
          return GestureDetector(
            onTap: () => setState(() => _selectedSize = size),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 72, height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: sel
                    ? const LinearGradient(
                        colors: [AppColors.primaryColor, AppColors.secondaryColor],
                        begin: Alignment.topLeft, end: Alignment.bottomRight)
                    : null,
                color: sel ? null : AppColors.cardColor,
                border: Border.all(
                  color: sel ? Colors.transparent : AppColors.borderColor,
                  width: 2,
                ),
                boxShadow: sel
                    ? [BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.5),
                        blurRadius: 20, spreadRadius: 2)]
                    : null,
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('$size×$size',
                    style: TextStyle(
                      color: sel ? Colors.white : AppColors.textLightColor,
                      fontSize: 18, fontWeight: FontWeight.bold,
                    )),
                Text('${size * size - 1} tiles',
                    style: TextStyle(
                      color: sel ? Colors.white70 : AppColors.textLightColor.withOpacity(0.7),
                      fontSize: 10,
                    )),
              ]),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  Widget _buildPlayBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => GameScreen(size: _selectedSize),
          transitionsBuilder: (_, a, __, child) =>
              FadeTransition(opacity: a, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ),
      child: Container(
        width: 220, height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor, AppColors.accentColor],
          ),
          boxShadow: [BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.6),
            blurRadius: 25, spreadRadius: 2,
          )],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text('PLAY NOW', style: AppTextStyles.buttonTextStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToBtn() {
    return GestureDetector(
      onTap: () => setState(() => _showHowTo = true),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.borderColor, width: 1.5),
        ),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.help_outline_rounded, color: AppColors.textColor, size: 17),
          SizedBox(width: 8),
          Text('HOW TO PLAY',
              style: TextStyle(
                color: AppColors.textColor, fontSize: 12,
                fontWeight: FontWeight.w600, letterSpacing: 2,
              )),
        ]),
      ),
    );
  }

  Widget _buildHowToPage() {
    final steps = [
      ['🎯', 'THE GOAL', 'Arrange numbers from 1 to the end\nin order from left to right and top to bottom'],
      ['👆', 'HOW TO PLAY', 'Tap any tile next to the empty space\nThe tile slides toward the empty space'],
      ['✅', 'GREEN TILE', 'When it turns green = it\'s in the correct position!'],
      ['🔵', 'THE SMALL DOT', 'A white dot = this tile can move'],
      ['🔄', 'SHUFFLE', 'Mixes the numbers again to start a new game'],
      ['🏆', 'WINNING', 'When you arrange all correctly, the victory screen appears!'],
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const SizedBox(height: 20),
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFFA78BFA), Color(0xFF60A5FA)],
          ).createShader(b),
          child: const Text('HOW TO PLAY',
              style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w900,
                color: Colors.white, letterSpacing: 3,
              )),
        ),
        const SizedBox(height: 4),
        const Text('HOW TO PLAY',
            style: TextStyle(color: AppColors.textLightColor, fontSize: 10, letterSpacing: 5)),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            itemCount: steps.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.cardColor,
                border: Border.all(color: AppColors.borderColor, width: 1),
              ),
              child: Row(children: [
                Container(
                  width: 46, height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      AppColors.primaryColor.withOpacity(0.25),
                      AppColors.secondaryColor.withOpacity(0.25),
                    ]),
                  ),
                  child: Center(child: Text(steps[i][0], style: const TextStyle(fontSize: 20))),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(steps[i][1],
                        style: const TextStyle(
                          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 3),
                    Text(steps[i][2],
                        style: const TextStyle(
                          color: AppColors.textColor, fontSize: 11, height: 1.5)),
                  ],
                )),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => setState(() => _showHowTo = false),
          child: Container(
            width: 200, height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor]),
              boxShadow: [BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.5),
                blurRadius: 18, spreadRadius: 2,
              )],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('BACK',
                    style: TextStyle(
                      color: Colors.white, fontSize: 14,
                      fontWeight: FontWeight.w800, letterSpacing: 3,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
      ]),
    );
  }
}