import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static final Connectivity _connectivity = Connectivity();

  /// Returns `true` if connected, `false` otherwise.
  static Future<bool> isConnected() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

  /// Yields `true` if connected, `false` otherwise.
  static Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((event) {
      return event != ConnectivityResult.none;
    });
  }
}
