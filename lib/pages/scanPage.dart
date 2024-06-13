// ignore_for_file: avoid_print

import 'package:blemanager/pages/deviceManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class Scanpage extends StatefulWidget {
  const Scanpage({super.key});

  @override
  State<Scanpage> createState() => _ScanpageState();
}

class _ScanpageState extends State<Scanpage> {
  FlutterBlue blueInstance = FlutterBlue.instance;
  void _disconnect() {
    blueInstance.connectedDevices.then((devices) {
      for (var device in devices) {
        device.disconnect();
      }
    });
  }

  void _scanDevices() {
    bool isFound = false;
    blueInstance.startScan(
        timeout: Duration(seconds: 20), allowDuplicates: false);
    blueInstance.scanResults.listen((results) async {
      if (!isFound) {
        for (var result in results) {
          if (result.device.id == const DeviceIdentifier("10:CE:A9:0C:7F:C4")) {
            isFound = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DevicePage(
                        blueInstance: blueInstance, moduleResult: result)));
            blueInstance.stopScan();
            return;
          }
        }
      }
    });
  }

  void runScan() async {
    _disconnect();
    isBluetoothEnabled()?.then(
      (value) {
        if (!value) {
          return;
        }
      },
    );
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
      Permission.bluetoothAdvertise
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      _scanDevices();
    } else {
      const AlertDialog(
        title: Text("Permissions not given."),
      );
    }
  }

  Future<bool>? isBluetoothEnabled() {
    blueInstance.isOn.then(
      (value) {
        if (value) {
          return value;
        } else {
          return value;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    runScan();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Searching..."),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 80,
          width: 120,
          child: ElevatedButton(
              onPressed: () => runScan(), child: Text("Scan...")),
        ),
      ),
    );
  }
}
