import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'screens/home_screen.dart';

class PuzzleApp extends StatelessWidget {
  const PuzzleApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUZZLE NOVA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}