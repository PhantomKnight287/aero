import 'package:aero/services/wear_os.dart';
import 'package:flutter/material.dart';

class WearablesScreen extends StatefulWidget {
  const WearablesScreen({super.key});

  @override
  State<WearablesScreen> createState() => _WearablesScreenState();
}

class _WearablesScreenState extends State<WearablesScreen> {
  final WearOSService _wearOSService = WearOSService();
  List<WearOSDevice> _connectedDevices = [];
  bool _noDeviceFound = false;
  bool _refreshing = false;
  Future<void> _loadDevices() async {
    setState(() {
      _refreshing = true;
    });
    final devices = await _wearOSService.getConnectedDevices();
    setState(() {
      _connectedDevices = devices;
      _noDeviceFound = devices.isEmpty;
      _refreshing = false;
    });
  }

  @override
  void initState() {
    _loadDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WearOS devices",
        ),
        actions: [
          IconButton(
            onPressed: _loadDevices,
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 1000),
              turns: _refreshing ? -1 : 0,
              child: Icon(
                Icons.refresh,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          if (_noDeviceFound)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "No WearOS devices found. Make sure your watch is connected to your phone via Bluetooth and try refreshing.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _connectedDevices.length,
              itemBuilder: (context, index) {
                final device = _connectedDevices[index];
                return ListTile(
                  title: Text(device.displayName),
                  subtitle: Text(device.id),
                  trailing: Icon(
                    device.isNearby ? Icons.check_circle : Icons.warning,
                    color: device.isNearby ? Colors.green : Colors.orange,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
