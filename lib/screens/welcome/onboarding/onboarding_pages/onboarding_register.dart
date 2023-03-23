import 'dart:io';

import 'package:danny/constants/text_styles.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/services/firebase_storage_service.dart';
import 'package:danny/services/firestore_path.dart';
import 'package:danny/services/firestore_service.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/input_field.dart';
import 'package:danny/widgets/notifications/error_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingRegister extends StatefulWidget {
  const OnboardingRegister({
    Key? key,
    required this.displayName,
    required this.photo,
  }) : super(key: key);

  final String displayName;
  final File? photo;

  @override
  _OnboardingRegisterState createState() => _OnboardingRegisterState();
}

class _OnboardingRegisterState extends State<OnboardingRegister> {
  String email = '';
  String password = '';
  String passwordR = '';
  bool showSpinner = false;

  void _showError(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: ErrorNotification(text),
      ),
    );
  }

  Future<void> _register() async {
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    final storage = Provider.of<FirebaseStorageService>(context, listen: false);
    if (password != passwordR) {
      _showError('Bro, match your passwords');
      return;
    }
    setState(() => showSpinner = true);
    try {
      final user = await auth.createUserWithEmailAndPassword(email, password);
      final photoUrl = widget.photo != null
          ? await storage.uploadImage(user.uid, widget.photo!)
          : '';

      final userInfo = UserData(
        ratings: 0,
        trackers: 0,
        streak: 0,
        danny: 0,
        generated: 0,
        shared: 0,
        rawAchievements: '000000000000000000000000000000000',
        displayName:
            widget.displayName == '' ? 'Anonymous' : widget.displayName,
        photoUrl: photoUrl,
        enableRatings: false,
      );

      await FirestoreService.instance.setData(
        path: FirestorePath.userInfo(user.uid),
        data: userInfo.toJson(),
      );
    } on FirebaseAuthException catch (e) {
      String authError;
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          authError = 'Invalid Email';
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          authError = 'Email already in use';
          break;
        case 'ERROR_WEAK_PASSWORD':
          authError = 'Weak Password';
          break;
        default:
          authError = 'Error';
          break;
      }
      setState(() => showSpinner = false);
      _showError(authError);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Now you just need to create your account!',
            style: AppTextStyles.textLightM,
          ),
        ),
        const Spacer(flex: 4),
        InputField(
          label: 'ACCOUNT EMAIL',
          hint: 'Email',
          keyboard: TextInputType.emailAddress,
          onChanged: (value) => setState(() => email = value),
        ),
        const Spacer(),
        InputField(
          label: 'ACCOUNT PASSWORD',
          hint: 'Password',
          obscureText: true,
          onChanged: (value) => setState(() => password = value),
        ),
        const Spacer(),
        InputField(
          label: 'REPEAT ACCOUNT PASSWORD',
          hint: 'Repeat Password',
          obscureText: true,
          onChanged: (value) => setState(() => passwordR = value),
        ),
        const Spacer(flex: 5),
        GenericButton(
          title: 'SIGN UP',
          light: true,
          onPressed: _register,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
