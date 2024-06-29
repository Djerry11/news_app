import 'package:intl/intl.dart';

//daTE TIME FORMATTER for the news list tile
String formatDateTime(String dateTimeStr) {
  // Parse the input date time string
  DateTime parsedDateTime = DateTime.parse(dateTimeStr);

  // Format the date as required
  String formattedDate = DateFormat('d MMM, yyyy').format(parsedDateTime);

  // Calculate the difference from the current time
  Duration difference = DateTime.now().toUtc().difference(parsedDateTime);

  // Determine if the difference is in minutes or hours
  String timeDifference;
  if (difference.inHours >= 1) {
    timeDifference =
        '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
  } else {
    timeDifference =
        '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
  }

  // Combine the formatted date and time difference
  return "${formattedDate}X$timeDifference";
}
