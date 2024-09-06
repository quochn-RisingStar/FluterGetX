import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef WifiListener = Function(bool enabled);

class WifiService {
  WifiService({WifiListener? listener}) {
    if (_subscription != null) {
      _subscription!.cancel();
    }
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      // Got a new connectivity status!
      if (listener != null) {
        listener(result.contains(ConnectivityResult.none)); //check later
      }
    });
  }

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  static Future<bool> isConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  static Future<bool> isDisconnect() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.none); //check later
  }

  static Future<bool> isNetWorkConnect() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return false;
      // Connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return false;
  }

  void close() {
    _subscription?.cancel();
  }
}
