import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker {
  final listener = InternetConnection().onStatusChange.listen(
    (InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:

          // The internet is now connected
          break;
        case InternetStatus.disconnected:
          // The internet is now disconnected
          break;
      }
    },
  );
}
