import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDate() {
    return DateFormat.yMMMd().format(this);
  }

  String toTime() {
    return DateFormat().add_jm().format(this);
  }
}

extension AppStringExtension on String {
  String toUSD() {
    return '\$$this';
  }
}
