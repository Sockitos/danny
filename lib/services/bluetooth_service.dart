import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:danny/models/rating.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BluetoothService {
  BluetoothService({required this.database});

  final FirestoreDatabase database;
  final FlutterReactiveBle _bleManager = FlutterReactiveBle();
  DiscoveredDevice? _device;

  BleStatus? currentStatus;
  StreamSubscription? discoverySub;
  StreamSubscription? settingsSub;
  StreamSubscription? characteristicSub;
  bool busy = false;
  bool sending = false;

  Future<void> backgroundCheck() async {
    log('Background Cheking');
    start();
    await Future<void>.delayed(const Duration(seconds: 10));
    await backgroundStop();
  }

  Future<void> backgroundStop() async {
    while (busy) {
      await Future<void>.delayed(const Duration(seconds: 5));
    }
    if (!busy) await Future<void>.delayed(const Duration(seconds: 5));
    if (busy) {
      await backgroundStop();
    } else {
      await stop();
    }
  }

  void start() {
    _bleManager.statusStream.listen((btState) {
      currentStatus = btState;
      doStuff(btState);
    });
  }

  void doStuff(BleStatus? btState) {
    log(btState.toString());
    switch (btState) {
      case BleStatus.ready:
        {
          log('Starting Scan');
          discoverySub = _bleManager.scanForDevices(
            scanMode: ScanMode.lowLatency,
            withServices: [
              Uuid.parse('0000dfb0-0000-1000-8000-00805f9b34fb'),
            ],
          ).listen((scanResult) {
            log('Scanned Peripheral ${scanResult.id}-${scanResult.name}, RSSI ${scanResult.rssi}');
            discoverySub?.cancel();

            connect(scanResult);
          });
        }
        break;
      default:
        discoverySub?.cancel();
    }
  }

  Future<void> stop() async {
    await discoverySub?.cancel();
    await _bleManager.deinitialize();
  }

  void connect(DiscoveredDevice device) {
    log('Connecting to Bluno');
    _bleManager
        .connectToAdvertisingDevice(
      id: device.id,
      withServices: [Uuid.parse('0000dfb0-0000-1000-8000-00805f9b34fb')],
      prescanDuration: const Duration(seconds: 2),
      servicesWithCharacteristicsToDiscover: {
        Uuid.parse('0000dfb0-0000-1000-8000-00805f9b34fb'): [
          Uuid.parse('0000dfb1-0000-1000-8000-00805f9b34fb')
        ]
      },
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((connectionStateUpdate) async {
      log(connectionStateUpdate.connectionState.toString());
      switch (connectionStateUpdate.connectionState) {
        case DeviceConnectionState.connected:
          {
            _device = device;
            getData();
            await sendConfig();
          }
          break;
        case DeviceConnectionState.disconnected:
          {
            await Future<void>.delayed(const Duration(milliseconds: 2000));
            _device = null;
            await characteristicSub?.cancel();
            await settingsSub?.cancel();
            sending = false;
            doStuff(currentStatus);
          }
          break;
        default:
      }
    });
  }

  void getData() {
    if (_device == null) return;
    var stuffs = '';

    Map<String, dynamic> json;
    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse('0000dfb0-0000-1000-8000-00805f9b34fb'),
      characteristicId: Uuid.parse('0000dfb1-0000-1000-8000-00805f9b34fb'),
      deviceId: _device!.id,
    );
    characteristicSub =
        _bleManager.subscribeToCharacteristic(characteristic).listen(
      (onData) async {
        log('NEW DATA RECEIVED');
        busy = true;
        stuffs = stuffs + utf8.decode(onData);
        try {
          json = jsonDecode(stuffs) as Map<String, dynamic>;
          await _bleManager.writeCharacteristicWithoutResponse(
            characteristic,
            value: utf8.encode('K'),
          );
          stuffs = '';
        } on FormatException catch (_) {
          return;
        }
        await database.setRating(Rating.fromBLEJson(json));
        busy = false;
      },
    );
    log('LISTENING');
  }

  Future<void> sendConfig() async {
    if (_device == null) return;
    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse('0000dfb0-0000-1000-8000-00805f9b34fb'),
      characteristicId: Uuid.parse('0000dfb1-0000-1000-8000-00805f9b34fb'),
      deviceId: _device!.id,
    );
    final prefs = await SharedPreferences.getInstance();
    final updated = prefs.getBool('configUpdated') ?? false;
    if (sending) return;

    if (updated) {
      await _bleManager.writeCharacteristicWithoutResponse(
        characteristic,
        value: utf8.encode('h'),
      );

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await _bleManager.writeCharacteristicWithoutResponse(
        characteristic,
        value: utf8.encode('r'),
      );
      log('CONFIG ALREADY UPDATED');
      return;
    }
    if (sending) return;

    sending = true;
    settingsSub = database.userTrackersStream().listen((data) async {
      busy = true;

      await _bleManager.writeCharacteristicWithoutResponse(
        characteristic,
        value: utf8.encode('h'),
      );
      await Future<void>.delayed(const Duration(milliseconds: 1000));

      final res = StringBuffer('<');
      for (final tracker in data) {
        res.write('${tracker.id},');
      }
      res.write('>');
      final toSend = utf8.encode('c$res');
      for (var i = 0; i < toSend.length; i += 20) {
        final end = (i + 20 < toSend.length) ? i + 20 : toSend.length;
        await Future<void>.delayed(const Duration(milliseconds: 1000));
        await _bleManager.writeCharacteristicWithoutResponse(
          characteristic,
          value: toSend.sublist(i, end),
        );
      }
      log('SENDING CONFIG');
      await prefs.setBool('configUpdated', true);
      busy = false;
    });
  }
}
