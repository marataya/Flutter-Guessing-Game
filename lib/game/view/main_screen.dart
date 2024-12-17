import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/guessing_game_bloc.dart';
import '../bloc/guessing_game_events.dart';
import '../bloc/guessing_game_state.dart';
import 'background.dart';

class GuessingGameScreen extends StatefulWidget {
  const GuessingGameScreen({super.key});

  @override
  State<GuessingGameScreen> createState() => _GuessingGameScreenState();
}

class _GuessingGameScreenState extends State<GuessingGameScreen> {
  int attempts = 10;
  int minNumber = 1;
  int maxNumber = 100;
  int guess = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Guessing Game')),
      body: Stack(
        children: [
          Background(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<GuessingGameBloc, GuessingGameState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text('Attempts: $attempts'),
                        Slider(
                          value: attempts.toDouble(),
                          min: 1,
                          max: 20,
                          onChanged: (value) =>
                              setState(() => attempts = value.toInt()),
                        ),
                        Text('Number Range: $minNumber - $maxNumber'),
                        RangeSlider(
                          values: RangeValues(
                              minNumber.toDouble(), maxNumber.toDouble()),
                          min: 1,
                          max: 200,
                          onChanged: (values) => setState(() {
                            minNumber = values.start.toInt();
                            maxNumber = values.end.toInt();
                          }),
                        ),
                        ElevatedButton(
                          onPressed: () => context.read<GuessingGameBloc>().add(
                              StartGame(
                                  attempts: attempts,
                                  minNumber: minNumber,
                                  maxNumber: maxNumber)),
                          child: const Text('Start Game'),
                        ),
                        if (state is GameInProgress) ...[
                          Text('Remaining Attempts: ${state.remainingAttempts}'),
                          Text(state.message),
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final parsed = int.tryParse(value);
                              if (parsed != null) {
                                setState(() {
                                  guess = parsed;
                                  if (guess < minNumber) {
                                    guess = minNumber;
                                  }
                                  if (guess > maxNumber) {
                                    guess = maxNumber;
                                  }
                                });
                              }
                            },
                            decoration:
                                const InputDecoration(labelText: 'Your Guess'),
                          ),
                          ElevatedButton(
                            onPressed: () => context
                                .read<GuessingGameBloc>()
                                .add(MakeGuess(guess)),
                            child: const Text('Make Guess'),
                          ),
                        ],
                        if (state is GameWon)
                          Text('You Won! Number was ${state.secretNumber}'),
                        if (state is GameOver)
                          Text('Game Over! Number was ${state.secretNumber}'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
