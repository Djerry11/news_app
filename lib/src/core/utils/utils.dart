import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String formatDateTime(String dateTimeStr) {
  // Parse the input date time string
  DateTime parsedDateTime = DateTime.parse(dateTimeStr);

  // Format the date as required
  String formattedDate = DateFormat('d MMM, yyyy').format(parsedDateTime);

  // Calculate the difference from the current time
  Duration difference = DateTime.now().toUtc().difference(parsedDateTime);

  // Determine the difference in weeks and days
  int differenceInDays = difference.inDays;
  int differenceInWeeks = (differenceInDays / 7).floor();
  int remainingDays = differenceInDays % 7;

  // Determine if the difference is in minutes, hours, days, or weeks
  String timeDifference;
  if (differenceInDays >= 7) {
    timeDifference = '$differenceInWeeks wk${differenceInWeeks > 1 ? 's' : ''}';
    if (remainingDays > 0) {
      timeDifference += ' $remainingDays day${remainingDays > 1 ? 's' : ''}';
    }
    timeDifference += ' ago';
  } else if (differenceInDays >= 1) {
    timeDifference =
        '$differenceInDays day${differenceInDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours >= 1) {
    timeDifference =
        '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
  } else {
    timeDifference =
        '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
  }

  // Combine the formatted date and time difference
  return '${formattedDate}X$timeDifference';
}

// add your api key here
String getApiKey() {
  // const newsApiKey = String.fromEnvironment('NEWS_API_KEY');
  // if (newsApiKey.isEmpty) {
  //   throw AssertionError('NEWS_API_KEY is not set');
  // }
  final newsApiKey = dotenv.env['NEWS_API_KEY3'];
  return newsApiKey!;
}

// snackbar dialog function
void showSnackbarDialog(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(
        message,
        style: TextStyle(
          color: color,
        ),
      ),
    ),
  );
}
