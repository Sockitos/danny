import 'package:danny/constants/colors.dart';
import 'package:danny/models/weekly.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({Key? key}) : super(key: key);

  Widget _buildSection(String title, String text) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final weekly = db.weeklyStream();

    return Scaffold(
      backgroundColor: AppColors.kprimary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const DannyAvatar(glow: true, active: false),
              const Text(
                'Hello there!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<Weekly>(
                  stream: weekly,
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSection(
                                  'Question',
                                  snapshot.data!.question,
                                ),
                                _buildSection(
                                  'Challenge',
                                  snapshot.data!.challenge,
                                ),
                                _buildSection(
                                  'Recommendation',
                                  snapshot.data!.recommendation,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ),
              const SizedBox(height: 40),
              GenericButton(
                title: 'THANK YOU!',
                onPressed: () => Navigator.pop(context),
                light: true,
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
