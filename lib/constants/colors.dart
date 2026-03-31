import 'package:flutter/material.dart';

// ─────────────── SAFE TILE COLORS (no HSL, no overflow) ───────────────
const _kColors1 = [
  Color(0xFF7C3AED), Color(0xFF2563EB), Color(0xFFDB2777), Color(0xFF059669),
  Color(0xFFD97706), Color(0xFF0891B2), Color(0xFF9333EA), Color(0xFF16A34A),
  Color(0xFFEA580C), Color(0xFF0284C7), Color(0xFFBE185D), Color(0xFF15803D),
  Color(0xFFB45309), Color(0xFF1D4ED8), Color(0xFF6D28D9), Color(0xFF047857),
  Color(0xFFC2410C), Color(0xFF0369A1), Color(0xFF7E22CE), Color(0xFF166534),
  Color(0xFF92400E), Color(0xFF1E40AF), Color(0xFF5B21B6), Color(0xFF064E3B),
];
const _kColors2 = [
  Color(0xFF4F46E5), Color(0xFF1D4ED8), Color(0xFF9D174D), Color(0xFF047857),
  Color(0xFFB45309), Color(0xFF0E7490), Color(0xFF6D28D9), Color(0xFF15803D),
  Color(0xFFC2410C), Color(0xFF0369A1), Color(0xFF9D174D), Color(0xFF166534),
  Color(0xFF92400E), Color(0xFF1E3A8A), Color(0xFF581C87), Color(0xFF064E3B),
  Color(0xFF7C2D12), Color(0xFF075985), Color(0xFF4C1D95), Color(0xFF14532D),
  Color(0xFF78350F), Color(0xFF1E3A8A), Color(0xFF3B0764), Color(0xFF022C22),
];

Color tileC1(int v) => _kColors1[v % _kColors1.length];
Color tileC2(int v) => _kColors2[v % _kColors2.length];