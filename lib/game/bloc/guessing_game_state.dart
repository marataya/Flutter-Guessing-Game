abstract class GuessingGameState {}

class GameInitial extends GuessingGameState {}

class GameInProgress extends GuessingGameState {
  final int remainingAttempts;
  final String message;

  GameInProgress({required this.remainingAttempts, this.message = ''});
}

class GameWon extends GuessingGameState {
  final int secretNumber;
  GameWon({required this.secretNumber});
}

class GameOver extends GuessingGameState {
  final int secretNumber;
  GameOver({required this.secretNumber});
}
