import 'package:animations/animations.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/text_styles.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/buttons/goback_button.dart';
import 'package:danny/widgets/buttons/text_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/dialogs/contacts.dart';
import 'package:danny/widgets/input_field.dart';
import 'package:danny/widgets/notifications/error_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email = '';
  String password = '';

  void _showError(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: ErrorNotification(text),
      ),
    );
  }

  Future<void> _login() async {
    setState(() => showSpinner = true);
    try {
      await Provider.of<FirebaseAuthService>(context, listen: false)
          .signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      String authError;
      switch (e.code) {
        case 'ERROR_INVALID_CREDENTIAL':
          authError = 'Invalid Credential';
          break;
        case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
          authError = 'Account exists with different crendital';
          break;
        case 'ERROR_WRONG_PASSWORD':
          authError = 'Wrong Password';
          break;
        case 'ERROR_INVALID_EMAIL':
          authError = 'Invalid Email';
          break;
        case 'ERROR_USER_NOT_FOUND':
          authError = 'User not found';
          break;
        default:
          authError = 'Sign In Error';
          break;
      }
      _showError(authError);
      setState(() => showSpinner = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kprimary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const GoBackButton(light: true),
          Center(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: DannyAvatar(glow: true, active: false),
                ),
                const Text(
                  'Welcome back!\nPlease login..',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textLightL,
                ),
                const Spacer(flex: 4),
                InputField(
                  label: 'ACCOUNT EMAIL',
                  hint: 'Email',
                  keyboard: TextInputType.emailAddress,
                  onChanged: (value) => email = value,
                ),
                const Spacer(),
                InputField(
                  label: 'ACCOUNT PASSWORD',
                  hint: 'Password',
                  obscureText: true,
                  onChanged: (value) => password = value,
                ),
                const Spacer(flex: 4),
                GenericButton(
                  title: 'SIGN IN',
                  light: true,
                  onPressed: _login,
                ),
                const SizedBox(height: 10),
                MyTextButton(
                  callback: () => showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Contacts(),
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black54,
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeScaleTransition(
                        animation: animation,
                        child: child,
                      );
                    },
                  ),
                  label: 'I Forgot Something',
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
