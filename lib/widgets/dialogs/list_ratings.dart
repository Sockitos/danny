import 'package:animations/animations.dart';
import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/dialogs/rating_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListRatings extends StatelessWidget {
  const ListRatings({
    Key? key,
    required this.ratings,
  }) : super(key: key);

  final List<Rating> ratings;
  static DateFormat dateFormat1 = DateFormat('MMMM d');
  static DateFormat dateFormat2 = DateFormat("HH'h'mm");

  double _getAverage() {
    if (ratings.isEmpty) return 0;
    var sum = 0.0;
    for (final r in ratings) {
      sum += r.rating;
    }
    return sum / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);

    return Dialog(
      backgroundColor: AppColors.kbackground,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorders.borderM,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: AppColors.ksecondary.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Feedback.forTap(context);
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              Text(
                dateFormat1.format(ratings.first.auxTimestamp),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ksecondary,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _getAverage().toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kprimary,
                ),
              ),
              Text(
                'Average',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ksecondary.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                thickness: 2,
                color: AppColors.ksecondary.withOpacity(0.1),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: ratings.length,
                  itemBuilder: (context, index) {
                    final r = ratings[index];
                    return StreamBuilder<Rating>(
                      stream: db.ratingStream(ratingId: r.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const SizedBox();
                        }
                        return Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                showGeneralDialog(
                                  context: context,
                                  pageBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                  ) =>
                                      RatingDetails(rating: r, close: false),
                                  barrierDismissible: true,
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .modalBarrierDismissLabel,
                                  barrierColor: Colors.black12,
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
                              child: Ink(
                                padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: AppColors
                                                .kratings[r.rating - 1],
                                          ),
                                          SizedBox(
                                            width: 32,
                                            height: 32,
                                            child: Center(
                                              child: Text(
                                                r.rating.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      r.tracker,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.ksecondary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Transform.translate(
                                        offset: const Offset(0, 1),
                                        child: Divider(
                                          indent: 4,
                                          endIndent: 4,
                                          color: AppColors.ksecondary
                                              .withOpacity(0.1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      dateFormat2.format(r.timestamp),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.ksecondary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: AppColors.ksecondary.withOpacity(0.1),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
