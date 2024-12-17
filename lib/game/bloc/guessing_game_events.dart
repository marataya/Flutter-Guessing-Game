abstract class GuessingGameEvent {}

class StartGame extends GuessingGameEvent {
  final int attempts;
  final int minNumber;
  final int maxNumber;

  StartGame({required this.attempts, required this.minNumber, required this.maxNumber});
}

class MakeGuess extends GuessingGameEvent {
  final int guess;

  MakeGuess(this.guess);
}
