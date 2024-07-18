import 'package:flutter/material.dart';

void scaffoldMessenger(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String timeAgo(String dateTimeString) {
  DateTime inputDateTime = DateTime.parse(dateTimeString).toUtc();
  DateTime currentDateTime = DateTime.now().toUtc();
  Duration difference = currentDateTime.difference(inputDateTime);

  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else {
    return "${difference.inDays} day(s) ago";
  }
}
