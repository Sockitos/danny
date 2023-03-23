import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/router/router.dart';
import 'package:danny/screens/main/main_screen.dart';
import 'package:danny/screens/welcome/welcome_screen.dart';
import 'package:danny/services/background_service.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/services/firebase_storage_service.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DanApp extends StatefulWidget {
  const DanApp({
    Key? key,
    required this.authServiceBuilder,
    required this.storageServiceBuilder,
    required this.databaseBuilder,
    required this.backgroundServiceBuilder,
  }) : super(key: key);

  final BackgroundService Function(BuildContext context)
      backgroundServiceBuilder;
  final FirebaseAuthService Function(BuildContext context) authServiceBuilder;
  final FirebaseStorageService Function(BuildContext context)
      storageServiceBuilder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  _DanAppState createState() => _DanAppState();
}

class _DanAppState extends State<DanApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: widget.authServiceBuilder,
        ),
        Provider<FirebaseStorageService>(
          create: widget.storageServiceBuilder,
        ),
        Provider<BackgroundService>(
          create: widget.backgroundServiceBuilder,
        ),
        StreamProvider<ConnectivityResult?>.value(
          initialData: null,
          value: Connectivity().onConnectivityChanged,
        ),
      ],
      child: AuthWidgetBuilder(
        userProvidersBuilder: (_, user) => [
          Provider<FirestoreDatabase>(
            create: (_) => FirestoreDatabase(
              uid: user.uid,
            ),
          ),
        ],
        builder: (context, userSnapshot) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: AppColors.kprimary,
              fontFamily: 'Quicksand',
            ),
            debugShowCheckedModeBanner: false,
            home: AuthWidget(
              userSnapshot: userSnapshot,
              nonSignedInBuilder: (_) => const WelcomeScreen(),
              signedInBuilder: (_) => const MainScreen(),
            ),
            onGenerateRoute: MyRouter.generateRoute,
          );
        },
      ),
    );
  }
}
