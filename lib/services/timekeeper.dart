import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveDate() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now();
  final today = '${now.year}-${now.month}-${now.day}';
  await prefs.setString('lastDate', today);
}

Future<void> checkDate() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now();
  final today = '${now.year}-${now.month}-${now.day}';
  final lastDate = prefs.getString('lastDate');
  if (lastDate != today) {
    await prefs.setString('lastDate', today);
  } else {
  }
}

Future<bool> isNewWeek() async {
  final prefs = await SharedPreferences.getInstance();

  final now = DateTime.now();

  // Find Monday of the current week
  final monday = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: now.weekday - 1));

  final currentWeek = 
      '${monday.year}-${monday.month}-${monday.day}';

  final lastWeek = prefs.getString('lastWeek');

  if (lastWeek != currentWeek) {
    await prefs.setString('lastWeek', currentWeek);
    return true; // A new week has started
  }

  return false; // Still the same week
}