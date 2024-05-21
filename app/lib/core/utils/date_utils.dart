import 'package:intl/intl.dart';


class DateUtils {


  static String humanize(DateTime date, [String format = 'dd-MM-yyyy HH:mm:ss']) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }


  static String timeAgoSinceDate(DateTime date, {bool numericDates = true}) {
    final duration = DateTime.now().difference(date);
    if (duration.inDays > 365) {
      return (numericDates) ? '${(duration.inDays / 365).floor()}y' : 'a year ago';
    } else if (duration.inDays > 30) {
      return (numericDates) ? '${(duration.inDays / 30).floor()}m' : 'a month ago';
    } else if (duration.inDays > 7) {
      return (numericDates) ? '${(duration.inDays / 7).floor()}w' : 'a week ago';
    } else if (duration.inDays > 0) {
      return (numericDates) ? '${duration.inDays}d' : 'yesterday';
    } else if (duration.inHours > 0) {
      return (numericDates) ? '${duration.inHours}h' : 'an hour ago';
    } else if (duration.inMinutes > 0) {
      return (numericDates) ? '${duration.inMinutes}m' : 'a minute ago';
    } else {
      return 'just now';
    }
  }

}