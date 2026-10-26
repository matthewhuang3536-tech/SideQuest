import 'package:quest/shared/data.dart';



  getTaskDaily() {
    DateTime now = DateTime.now();

    int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;
    return daily2026quests[dayOfYear];
  }

  getTaskWeekly() {
    DateTime now = DateTime.now();

    int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;
    return weekly2026quests[dayOfYear ~/ 7];
  }
  getTaskMonthly() {
    DateTime now = DateTime.now();

    return monthly2026quests[now.month-1];
  }