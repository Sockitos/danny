import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:danny/app.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/services/background_service.dart';
import 'package:danny/services/bluetooth_service.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/services/firebase_storage_service.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> backgroundFetchHeadlessTask(String taskId) async {
  log('[BackgroundFetch] Headless event received.');
  await Firebase.initializeApp();
  final auth = FirebaseAuthService();
  final uid = auth.currentUser?.uid;
  if (uid == null) return;
  final db = FirestoreDatabase(uid: uid);
  final blue = BluetoothService(database: db);
  await blue.backgroundCheck();
  BackgroundFetch.finish(taskId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.kprimary,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  runApp(
    DanApp(
      authServiceBuilder: (_) => FirebaseAuthService(),
      storageServiceBuilder: (_) => FirebaseStorageService(),
      databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
      backgroundServiceBuilder: (_) => BackgroundService(),
    ),
  );

  await BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}
