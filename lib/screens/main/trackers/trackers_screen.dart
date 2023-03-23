import 'package:animations/animations.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/screens/main/trackers/components/add_tracker.dart';
import 'package:danny/screens/main/trackers/components/no_trackers.dart';
import 'package:danny/screens/main/trackers/components/tracker_card.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/buttons/side_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackersScreen extends StatefulWidget {
  const TrackersScreen({Key? key}) : super(key: key);

  @override
  _TrackersScreenState createState() => _TrackersScreenState();
}

class _TrackersScreenState extends State<TrackersScreen> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  @override
  void initState() {
    ctrl.addListener(() {
      final next = (ctrl.page ?? 0).round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final trackers = db.userTrackersStream();

    return Stack(
      children: <Widget>[
        const Positioned(
          left: 20,
          top: 30,
          child: DannyAvatar(),
        ),
        SideButton(
          callback: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AddTracker(),
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
          },
          icon: CustomIcons.mais,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'How are you?',
                  style: TextStyle(
                    color: AppColors.ksecondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Check your individual trackers',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ksecondary.withOpacity(0.3),
                  ),
                ),
              ),
              Flexible(
                child: StreamBuilder<List<Tracker>>(
                  stream: trackers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final slideList = snapshot.data ?? [];
                      return slideList.isEmpty
                          ? NoTrackers(
                              callback: () {
                                showGeneralDialog(
                                  context: context,
                                  pageBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                  ) =>
                                      const AddTracker(),
                                  barrierDismissible: true,
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .modalBarrierDismissLabel,
                                  barrierColor: Colors.black54,
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  transitionBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeScaleTransition(
                                      animation: animation,
                                      child: child,
                                    );
                                  },
                                );
                              },
                            )
                          : PageView.builder(
                              controller: ctrl,
                              itemCount: slideList.length,
                              itemBuilder: (context, index) {
                                final active = index == currentPage;
                                return TrackerCard(
                                  tracker: slideList[index],
                                  active: active,
                                  delete: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool('configUpdated', false);
                                    await db
                                        .deleteUserTracker(slideList[index]);
                                  },
                                );
                              },
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
