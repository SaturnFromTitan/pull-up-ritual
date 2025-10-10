String formatMinutesSeconds(int totalSeconds) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(totalSeconds ~/ 60);
  final seconds = twoDigits(totalSeconds % 60);
  return "$minutes:$seconds";
}
