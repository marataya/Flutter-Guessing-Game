import 'dart:math';
import 'package:bloc/bloc.dart';
import 'guessing_game_events.dart';
import 'guessing_game_state.dart';

class GuessingGameBloc extends Bloc<GuessingGameEvent, GuessingGameState> {
  int? secretNumber;
  int? maxAttempts;

  GuessingGameBloc() : super(GameInitial()) {
    on<StartGame>((event, emit) {
      secretNumber = Random().nextInt(event.maxNumber - event.minNumber + 1) +
          event.minNumber;
      maxAttempts = event.attempts;
      emit(GameInProgress(remainingAttempts: event.attempts));
    });

    on<MakeGuess>((event, emit) {
      if (state is GameInProgress) {
        final currentState = state as GameInProgress;
        int remainingAttempts = currentState.remainingAttempts - 1;

        if (event.guess == secretNumber) {
          emit(GameWon(secretNumber: secretNumber!));
        } else if (remainingAttempts == 0) {
          emit(GameOver(secretNumber: secretNumber!));
        } else if (event.guess < secretNumber!) {
          emit(GameInProgress(
              remainingAttempts: remainingAttempts, message: 'Too low!'));
        } else {
          emit(GameInProgress(
              remainingAttempts: remainingAttempts, message: 'Too high!'));
        }
      }
    });
  }
}
