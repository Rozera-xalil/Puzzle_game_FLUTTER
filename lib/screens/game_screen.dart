import 'dart:math';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/colors.dart';
import '../models/puzzle_state.dart';
import '../widgets/grid_painter.dart';

class GameScreen extends StatefulWidget {
  final int size;
  const GameScreen({super.key, required this.size});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late PuzzleState _puzzle;
  late AnimationController _solveCtrl;
  late AnimationController _bgCtrl;
  bool _showSolved = false;

  final Map<int, AnimationController> _tileAnims = {};
  final Map<int, Animation<double>> _tileScales = {};

  @override
  void initState() {
    super.initState();
    _puzzle = PuzzleState(size: widget.size);
    _solveCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _bgCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _solveCtrl.dispose();
    _bgCtrl.dispose();
    for (final c in _tileAnims.values) c.dispose();
    super.dispose();
  }

  void _tap(int index) {
    if (_showSolved) return;
    if (_puzzle.move(index)) {
      _animTile(index);
      setState(() {
        if (_puzzle.isSolved) {
          _showSolved = true;
          _solveCtrl.forward();
        }
      });
    }
  }

  void _animTile(int index) {
    _tileAnims[index]?.dispose();
    final ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    _tileAnims[index] = ctrl;
    _tileScales[index] = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.82), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.82, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut));
    ctrl.forward();
  }

  void _reset() {
    for (final c in _tileAnims.values) c.dispose();
    setState(() {
      _puzzle = PuzzleState(size: widget.size);
      _showSolved = false;
      _tileAnims.clear();
      _tileScales.clear();
      _solveCtrl.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AnimatedBuilder(
          animation: _bgCtrl,
          builder: (_, __) => Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(
                  sin(_bgCtrl.value * 2 * pi) * 0.4,
                  cos(_bgCtrl.value * 2 * pi) * 0.4,
                ),
                radius: 1.8,
                colors: const [
                  Color(0xFF1A0533), Color(0xFF0D1B3E), AppColors.backgroundColor,
                ],
              ),
            ),
          ),
        ),
        CustomPaint(size: Size.infinite, painter: GridPainter()),
        Center(
          child: Container(
            width: 340, height: 340,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [
                AppColors.primaryColor.withOpacity(0.12),
                Colors.transparent,
              ]),
            ),
          ),
        ),
        SafeArea(
          child: Column(children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildStats(),
            const Spacer(),
            _buildGrid(),
            const Spacer(),
            _buildBottom(),
            const SizedBox(height: 20),
          ]),
        ),
        if (_showSolved) _buildWin(),
      ]),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(children: [
        _iconBtn(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
        const Spacer(),
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFFA78BFA), Color(0xFF60A5FA)],
          ).createShader(b),
          child: Text('${widget.size}×${widget.size} PUZZLE',
              style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800,
                color: Colors.white, letterSpacing: 3,
              )),
        ),
        const Spacer(),
        _iconBtn(Icons.refresh_rounded, _reset),
      ]),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback fn) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.cardColor,
          border: Border.all(color: AppColors.borderColor, width: 1.5),
        ),
        child: Icon(icon, color: AppColors.textColor, size: 18),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stat('MOVES', '${_puzzle.moves}', AppColors.primaryColor),
        const SizedBox(width: 12),
        _stat('TILES', '${widget.size * widget.size - 1}', AppColors.secondaryColor),
        const SizedBox(width: 12),
        _stat('GRID', '${widget.size}×${widget.size}', AppColors.accentColor),
      ],
    );
  }

  Widget _stat(String lbl, String val, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: col.withOpacity(0.3), width: 1),
        color: col.withOpacity(0.06),
      ),
      child: Column(children: [
        Text(val, style: TextStyle(color: col, fontSize: 20, fontWeight: FontWeight.w900)),
        Text(lbl,
            style: const TextStyle(
                color: AppColors.textLightColor, fontSize: 9, letterSpacing: 2)),
      ]),
    );
  }

  Widget _buildGrid() {
    final sw = MediaQuery.of(context).size.width;
    final gs = (sw - 48).clamp(0.0, 370.0);
    return Container(
      width: gs, height: gs,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor, width: 1.5),
        boxShadow: [BoxShadow(
          color: AppColors.primaryColor.withOpacity(0.12),
          blurRadius: 40, spreadRadius: 8,
        )],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          color: const Color(0xFF060910),
          padding: const EdgeInsets.all(5),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.size,
              mainAxisSpacing: 5, crossAxisSpacing: 5,
            ),
            itemCount: widget.size * widget.size,
            itemBuilder: (_, i) => _buildTile(i, gs),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(int index, double gridSize) {
    final val = _puzzle.tiles[index];
    final total = widget.size * widget.size;
    final isBlank = val == total - 1;
    final isCorrect = val == index && !isBlank;
    final moveable = _puzzle.canMove(index) && !isBlank;
    final tileW = (gridSize - 10 - (widget.size - 1) * 5) / widget.size;

    if (isBlank) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF0A0F1A),
          border: Border.all(
              color: AppColors.borderColor.withOpacity(0.4), width: 1),
        ),
      );
    }

    final c1 = isCorrect ? AppColors.successColor : tileC1(val);
    final c2 = isCorrect ? const Color(0xFF047857) : tileC2(val);

    Widget tile = GestureDetector(
      onTap: () => _tap(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [c1, c2],
          ),
          boxShadow: [BoxShadow(
            color: c1.withOpacity(0.4),
            blurRadius: 6, offset: const Offset(0, 3),
          )],
          border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
        ),
        child: Stack(children: [
          Positioned(
            top: 0, left: 0, right: 0,
            height: tileW * 0.38,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.white.withOpacity(0.17), Colors.transparent],
                ),
              ),
            ),
          ),
          Center(
            child: Text('${val + 1}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontSize: (tileW * 0.36).clamp(10.0, 32.0),
                  fontWeight: FontWeight.w900,
                  shadows: [Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 2), blurRadius: 4,
                  )],
                )),
          ),
          if (moveable)
            Positioned(
              right: 5, bottom: 5,
              child: Container(
                width: 5, height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          if (isCorrect)
            Positioned(
              left: 5, top: 5,
              child: Icon(Icons.check_circle,
                  color: Colors.white.withOpacity(0.5),
                  size: (tileW * 0.22).clamp(8.0, 18.0)),
            ),
        ]),
      ),
    );

    if (_tileAnims.containsKey(index) && _tileScales.containsKey(index)) {
      tile = AnimatedBuilder(
        animation: _tileAnims[index]!,
        builder: (_, child) =>
            Transform.scale(scale: _tileScales[index]!.value, child: child),
        child: tile,
      );
    }
    return tile;
  }

  Widget _buildBottom() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _actionBtn(Icons.shuffle_rounded, 'SHUFFLE', AppColors.primaryColor, _reset),
      const SizedBox(width: 14),
      _actionBtn(Icons.help_outline_rounded, 'HOW TO', const Color(0xFF0891B2),
          _showHowTo),
    ]);
  }

  void _showHowTo() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ShaderMask(
              shaderCallback: (b) => const LinearGradient(
                colors: [Color(0xFFA78BFA), Color(0xFF60A5FA)],
              ).createShader(b),
              child: const Text('HOW TO PLAY',
                  style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w900,
                    color: Colors.white, letterSpacing: 3,
                  )),
            ),
            const SizedBox(height: 18),
            ...[
              ['👆', 'Press the tile adjacent to the empty space'],
              ['✅', 'Green tile = in its correct position'],
              ['🔵', 'Small dot = can move'],
              ['🏆', 'Arrange ${widget.size * widget.size - 1} numbers to win!'],
            ].map((s) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(children: [
                    Text(s[0], style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(s[1],
                        style: const TextStyle(
                            color: AppColors.textColor, fontSize: 13))),
                  ]),
                )),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 46, width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  gradient: const LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.secondaryColor]),
                ),
                child: const Center(
                  child: Text('GOT IT! 👍',
                      style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _actionBtn(
      IconData icon, String lbl, Color col, VoidCallback fn) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: col.withOpacity(0.08),
          border: Border.all(color: col.withOpacity(0.3), width: 1.5),
        ),
        child: Row(children: [
          Icon(icon, color: col, size: 18),
          const SizedBox(width: 8),
          Text(lbl,
              style: TextStyle(
                color: col, fontWeight: FontWeight.w700,
                letterSpacing: 2, fontSize: 12,
              )),
        ]),
      ),
    );
  }

  Widget _buildWin() {
    return AnimatedBuilder(
      animation: _solveCtrl,
      builder: (_, __) {
        final t = _solveCtrl.value;
        return Container(
          color: Colors.black.withOpacity(0.88 * t),
          child: Opacity(
            opacity: t,
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 110, height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                    boxShadow: [BoxShadow(
                      color: const Color(0xFFD97706).withOpacity(0.6),
                      blurRadius: 40, spreadRadius: 10,
                    )],
                  ),
                  child: const Icon(Icons.emoji_events_rounded,
                      color: Colors.white, size: 55),
                ),
                const SizedBox(height: 26),
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [Color(0xFFFCD34D), Color(0xFFFBBF24)],
                  ).createShader(b),
                  child: const Text('SOLVED! 🎉',
                      style: TextStyle(
                        fontSize: 42, fontWeight: FontWeight.w900,
                        color: Colors.white, letterSpacing: 6,
                      )),
                ),
                const SizedBox(height: 6),
                Text('${_puzzle.moves} MOVES',
                    style: const TextStyle(
                      color: AppColors.textColor, fontSize: 15, letterSpacing: 4)),
                const SizedBox(height: 36),
                _winBtn('PLAY AGAIN',
                    const [AppColors.primaryColor, AppColors.secondaryColor], _reset),
                const SizedBox(height: 12),
                _winBtn('MAIN MENU',
                    const [AppColors.borderColor, AppColors.cardColor],
                    () => Navigator.pop(context)),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _winBtn(String text, List<Color> cols, VoidCallback fn) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        width: 230, height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(colors: cols),
          boxShadow: [BoxShadow(
            color: cols[0].withOpacity(0.4),
            blurRadius: 18, spreadRadius: 2,
          )],
        ),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                color: Colors.white, fontSize: 14,
                fontWeight: FontWeight.w800, letterSpacing: 3,
              )),
        ),
      ),
    );
  }
}