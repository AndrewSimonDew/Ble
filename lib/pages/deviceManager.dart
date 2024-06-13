import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DevicePage extends StatefulWidget {
  final FlutterBlue blueInstance;
  final ScanResult moduleResult;
  const DevicePage(
      {super.key, required this.blueInstance, required this.moduleResult});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

String title = "Connecting...";

class _DevicePageState extends State<DevicePage> {
  late BluetoothCharacteristic characteristic;
  void _disconnect() {
    widget.blueInstance.connectedDevices.then((devices) {
      for (var device in devices) {
        device.disconnect();
      }
    });
  }

  void _connect() {
    widget.blueInstance.connectedDevices.then((devices) {
      if (devices.isEmpty) {
        widget.moduleResult.device.connect().then((value) {
          setState(() {
            title = "Discovering Services...";
          });
          getCharacteristic();
        });
        return;
      }
    });
  }

  void getCharacteristic() async {
    List<BluetoothService> services =
        await widget.moduleResult.device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic char in service.characteristics) {
        if (char.uuid == Guid('0000FFE1-0000-1000-8000-00805F9B34FB')) {
          characteristic = char;
          setState(() {
            title = "Connected.";
          });
        }
      }
    }
  }

  void sendData(List<int> data) {
    characteristic.write(data);
  }

  @override
  Widget build(BuildContext context) {
    _connect();
    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) => _disconnect(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      sendData(utf8.encode("hi"));
                    },
                    child: Text("piros")),
                ElevatedButton(
                    onPressed: () {
                      sendData([0x2]);
                    },
                    child: Text("sárga")),
                ElevatedButton(
                    onPressed: () {
                      sendData([0x3]);
                    },
                    child: Text("zöld")),
                ElevatedButton(
                    onPressed: () {
                      sendData([0x4]);
                    },
                    child: Text("kék")),
                ElevatedButton(
                    onPressed: () {
                      sendData([0x5]);
                    },
                    child: Text("Egyik se")),
                ElevatedButton(
                    onPressed: () {
                      sendData([0x6]);
                    },
                    child: Text("Mind")),
              ],
            ),
          ),
        ));
  }
}
