import 'package:flutter_blue/flutter_blue.dart';

class BTService {
  BTService({required String url});

  final FlutterBlue flutterBlue = FlutterBlue.instance;

  void startScaning() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    print("start scan");

    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

    // Stop scanning
    flutterBlue.stopScan();
  }
}
