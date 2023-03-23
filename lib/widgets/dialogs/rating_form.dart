import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RatingForm extends StatelessWidget {
  const RatingForm({
    Key? key,
    required this.tracker,
  }) : super(key: key);

  final Tracker tracker;

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
                  size: 24,
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
              const SizedBox(height: 20),
              Text(
                tracker.id,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ksecondary,
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                indent: 40,
                endIndent: 40,
                thickness: 2,
                color: AppColors.ksecondary.withOpacity(0.1),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    for (int i = 0; i < AppColors.kratings.length; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: AppColors.kratings[i],
                            onPressed: () {
                              db.setRating(
                                Rating(
                                  id: const Uuid().v1(),
                                  tracker: tracker.id,
                                  rating: i + 1,
                                  timestamp: DateTime.now(),
                                ),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                  ],
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
