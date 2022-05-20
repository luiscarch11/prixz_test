import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  int get age {
    final currentDate = DateTime.now();
    var ageToReturn = currentDate.year - year;
    if (_birthdayIsInTheFuture(currentDate)) ageToReturn--;
    return ageToReturn;
  }

  String get dateAndAgeString => '${(DateFormat.yMMMMd().format(this))} (age: $age)';
  bool _birthdayIsInTheFuture(DateTime currentDate) => currentDate.isBefore(
        DateTime(
          currentDate.year,
          month,
          day,
        ),
      );
}
