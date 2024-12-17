import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game/bloc/guessing_game_bloc.dart';
import 'game/view/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Guessing Game',
      home: BlocProvider(
        create: (context) => GuessingGameBloc(),
        child: const GuessingGameScreen(),
      ),
    );
  }
}
