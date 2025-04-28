import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String dayName() => DateFormat('EEEE').format(this);

  String monthName() => DateFormat('MMMM').format(this);

  String monthNameAndDay() => DateFormat('MMMM d').format(this);
}
