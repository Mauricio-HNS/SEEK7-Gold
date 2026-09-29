enum SeekRunStatus { idle, active, completed, cooldown }

class SeekRun {
  final int durationMinutes;
  final int maxAds;
  final SeekRunStatus status;
  final int remainingSeconds;
  final int completedSpots;

  const SeekRun({
    required this.durationMinutes,
    required this.maxAds,
    required this.status,
    required this.remainingSeconds,
    required this.completedSpots,
  });
}
