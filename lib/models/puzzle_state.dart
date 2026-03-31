import 'dart:math';

class PuzzleState {
  final int size;
  late List<int> tiles;
  int moves = 0;
  bool _solved = false;

  PuzzleState({required this.size}) {
    tiles = List.generate(size * size, (i) => i);
    _shuffle();
  }

  int get blankIndex => tiles.indexOf(size * size - 1);

  void _shuffle() {
    final rng = Random();
    do {
      tiles.shuffle(rng);
    } while (!_isSolvable() || _checkSolved());
    _solved = false;
    moves = 0;
  }

  bool _isSolvable() {
    int inv = 0;
    final flat = tiles.where((t) => t != size * size - 1).toList();
    for (int i = 0; i < flat.length - 1; i++) {
      for (int j = i + 1; j < flat.length; j++) {
        if (flat[i] > flat[j]) inv++;
      }
    }
    if (size.isOdd) return inv.isEven;
    final bRow = blankIndex ~/ size;
    return (inv + bRow).isEven;
  }

  bool _checkSolved() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != i) return false;
    }
    return true;
  }

  bool get isSolved => _solved;

  bool canMove(int index) {
    final b = blankIndex;
    final r = index ~/ size, c = index % size;
    final br = b ~/ size, bc = b % size;
    return (r == br && (c - bc).abs() == 1) || (c == bc && (r - br).abs() == 1);
  }

  bool move(int index) {
    if (!canMove(index)) return false;
    final b = blankIndex;
    tiles[b] = tiles[index];
    tiles[index] = size * size - 1;
    moves++;
    _solved = _checkSolved();
    return true;
  }
}