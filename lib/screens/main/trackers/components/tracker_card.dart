import 'package:animations/animations.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/screens/main/trackers/tracker/tracker_screen.dart';
import 'package:danny/widgets/dialogs/rating_form.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TrackerCard extends StatelessWidget {
  const TrackerCard({
    Key? key,
    required this.tracker,
    required this.active,
    required this.delete,
  }) : super(key: key);

  final Tracker tracker;
  final bool active;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    final blur = active ? 12.0 : 4.0;
    final offsetX = active ? 15.0 : 5.0;
    final offsetY = active ? 20.0 : 10.0;
    final top = active ? 20.0 : 50.0;
    final name = tracker.id;
    final userInfo = Provider.of<UserData>(context, listen: false);

    return Dismissible(
      onDismissed: (direction) => delete(),
      direction: DismissDirection.up,
      key: Key(tracker.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 30, right: 30),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: AppColors.kprimary.withOpacity(0.5),
                blurRadius: blur,
                offset: Offset(offsetX, offsetY),
              ),
            ],
          ),
          child: Material(
            color: AppColors.kprimary,
            borderRadius: BorderRadius.circular(35),
            child: InkWell(
              borderRadius: BorderRadius.circular(35),
              onTap: () {
                Navigator.push<void>(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: TrackerScreen(tracker: tracker),
                  ),
                );
              },
              onLongPress: userInfo.enableRatings
                  ? () {
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            RatingForm(tracker: tracker),
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
                      );
                    }
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 10, 50),
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 52,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -30,
                            left: -28,
                            child: Icon(
                              CustomIcons.chart,
                              size: 200,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
