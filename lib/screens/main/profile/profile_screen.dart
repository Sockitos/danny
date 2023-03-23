import 'dart:io';

import 'package:animations/animations.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/screens/main/profile/components/contact_info.dart';
import 'package:danny/screens/main/profile/components/counter.dart';
import 'package:danny/screens/main/profile/components/profile_nickname.dart';
import 'package:danny/screens/main/profile/components/profile_photo.dart';
import 'package:danny/screens/main/profile/components/square_button.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/services/firebase_storage_service.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/buttons/side_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/dialogs/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _updateProfile(
    String newDisplayName,
    PickedFile? photo,
    BuildContext context,
  ) async {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    final storage = Provider.of<FirebaseStorageService>(context, listen: false);
    final userInfo = Provider.of<UserData>(context, listen: false);

    final newPhotoUrl = photo != null
        ? await storage.uploadImage(auth.currentUser!.uid, File(photo.path))
        : '';

    final newUserInfo = UserData(
      ratings: userInfo.ratings,
      trackers: userInfo.trackers,
      streak: userInfo.streak,
      danny: userInfo.danny,
      generated: userInfo.generated,
      shared: userInfo.shared,
      rawAchievements: userInfo.rawAchievements,
      displayName: newDisplayName == '' ? userInfo.displayName : newDisplayName,
      photoUrl: newPhotoUrl == '' ? userInfo.photoUrl : newPhotoUrl,
      enableRatings: userInfo.enableRatings,
    );

    await db.setUserInfo(newUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserData>(context);
    return Stack(
      children: [
        const Positioned(
          left: 20,
          top: 30,
          child: DannyAvatar(),
        ),
        SideButton(
          callback: () async {
            final result = await showGeneralDialog<bool>(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const Confirmation(
                title: 'Log out',
                text: 'Are you sure you want to log out?',
              ),
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black54,
              transitionDuration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeScaleTransition(animation: animation, child: child);
              },
            );
            if (result ?? false) {
              await Provider.of<FirebaseAuthService>(context, listen: false)
                  .signOut();
            }
          },
          icon: CustomIcons.logout,
        ),
        Center(
          child: Column(
            children: [
              const Spacer(flex: 2),
              ProfilePhoto(
                photoUrl: userInfo.photoUrl,
                callback: _updateProfile,
              ),
              ProfileNickname(
                nickname: userInfo.displayName,
                callback: _updateProfile,
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Counter(
                      count: userInfo.ratings,
                      title: 'ratings',
                      icon: CustomIcons.pencil,
                    ),
                    Counter(
                      count: userInfo.streak,
                      title: 'streak',
                      icon: CustomIcons.streak,
                    ),
                    Counter(
                      count: userInfo.trackers,
                      title: 'trackers',
                      icon: CustomIcons.setting,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SquareButton(
                    callback: () {
                      Navigator.pushNamed(context, '/sharing');
                    },
                    icon: CustomIcons.share,
                    label: 'Sharing',
                  ),
                  SquareButton(
                    callback: () {
                      Navigator.pushNamed(context, '/achievements');
                    },
                    icon: CustomIcons.achievement,
                    label: 'Achievements',
                  ),
                ],
              ),
              const Spacer(flex: 8),
              const ContactInfo(),
            ],
          ),
        ),
      ],
    );
  }
}
