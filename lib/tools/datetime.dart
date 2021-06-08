DateTime todayWithTime(int hour, int minute) {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, hour, minute);
}
