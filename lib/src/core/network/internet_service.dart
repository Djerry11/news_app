import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final InternetConnection _connectionChecker = InternetConnection();

  Stream<bool> get onConnectivityChanged =>
      _connectionChecker.onStatusChange.map(
        (status) => status == InternetStatus.connected,
      );
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

class ConnectivityNotifier extends StateNotifier<bool> {
  ConnectivityNotifier(ConnectivityService connectivityService) : super(true) {
    connectivityService.onConnectivityChanged.listen((isConnected) {
      state = isConnected;
    });
  }
}

final connectivityNotifierProvider =
    StateNotifierProvider<ConnectivityNotifier, bool>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return ConnectivityNotifier(connectivityService);
});

final connectivityStatusProvider = StreamProvider<bool>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.onConnectivityChanged;
});
