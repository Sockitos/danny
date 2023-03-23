import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/screens/main/home/home_screen.dart';
import 'package:danny/screens/main/profile/profile_screen.dart';
import 'package:danny/screens/main/trackers/trackers_screen.dart';
import 'package:danny/services/background_service.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/navigation_dot_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FirestoreDatabase db;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);

    db = Provider.of<FirestoreDatabase>(context, listen: false);
    Provider.of<BackgroundService>(context, listen: false).start(db);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY,
        ), (dynamic taskId) async {
      // This is the fetch-event callback.
      log('[BackgroundFetch] Event received $taskId');

      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId as String);
    }).then((status) {
      log('[BackgroundFetch] configure success: $status');
      BackgroundFetch.start().then((status) {
        log('[BackgroundFetch] start success: $status');
      }).catchError((dynamic e) {
        log('[BackgroundFetch] start FAILURE: $e');
      });
    }).catchError((dynamic e) {
      log('[BackgroundFetch] configure ERROR: $e');
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  void dispose() {
    _tabController.dispose();
    Provider.of<BackgroundService>(context, listen: false).stop();
    super.dispose();
  }

  void _onItemTapped(int index) =>
      _tabController.animateTo(index, curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackground,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: StreamBuilder<UserData>(
          stream: db.userInfoStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final info = snapshot.data!;
              return Provider<UserData>.value(
                value: info,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    HomeScreen(),
                    TrackersScreen(),
                    ProfileScreen(),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationDotBar(
        onSelect: _onItemTapped,
        items: <BottomNavigationDotBarItem>[
          BottomNavigationDotBarItem(
            icon: CustomIcons.home,
            onTap: () => _onItemTapped(0),
          ),
          BottomNavigationDotBarItem(
            icon: CustomIcons.copy,
            onTap: () => _onItemTapped(1),
          ),
          BottomNavigationDotBarItem(
            icon: CustomIcons.profile,
            onTap: () => _onItemTapped(2),
          ),
        ],
      ),
    );
  }
}
