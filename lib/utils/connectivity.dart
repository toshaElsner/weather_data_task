import 'package:connectivity_plus/connectivity_plus.dart';


/// Check internet
Future<bool> hasConnectivity() async {
  var subscription = Connectivity();
  List<ConnectivityResult> check = await subscription.checkConnectivity();
  if (check.contains(ConnectivityResult.mobile) ||
      check.contains(ConnectivityResult.wifi)) {
    print("Internet On");
    return true;
  } else {
    print("Internet Off");
    return false;
  }
}