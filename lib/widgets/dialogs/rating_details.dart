import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/dialogs/rating_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RatingDetails extends StatelessWidget {
  const RatingDetails({
    Key? key,
    required this.rating,
    this.close = true,
  }) : super(key: key);

  final Rating rating;
  final bool close;
  static DateFormat dateFormat = DateFormat("MMM. d, HH'h'mm");

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
            top: close ? 5 : 12,
            right: close ? 5 : null,
            left: close ? null : 12,
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  close ? Icons.close : CustomIcons.back,
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
          StreamBuilder<Rating>(
            stream: db.ratingStream(ratingId: rating.id),
            initialData: rating,
            builder: (context, snapshot) {
              final r = snapshot.data ?? rating;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.kratings[r.rating - 1],
                        ),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Text(
                              r.rating.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
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
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ksecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    dateFormat.format(r.timestamp),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ksecondary.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Divider(
                    indent: 40,
                    endIndent: 40,
                    thickness: 2,
                    color: AppColors.ksecondary.withOpacity(0.1),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Add pictures of your notes',
                    style: TextStyle(
                      color: AppColors.ksecondary.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        RatingImage(
                          imageUrl: rating.imageUrl1,
                          onImageSelected: (_) {},
                        ),
                        const SizedBox(width: 10),
                        RatingImage(
                          imageUrl: rating.imageUrl2,
                          onImageSelected: (_) {},
                        ),
                        const SizedBox(width: 10),
                        RatingImage(
                          imageUrl: rating.imageUrl3,
                          onImageSelected: (_) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipOval(
                    child: Material(
                      color: AppColors.kprimary, // button color
                      child: InkWell(
                        splashColor:
                            Colors.white.withOpacity(0.1), // inkwell color
                        child: SizedBox(
                          width: 64,
                          height: 64,
                          child: Center(
                            child: Transform.translate(
                              offset: const Offset(1, 0),
                              child: const Icon(
                                CustomIcons.trash,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            db.deleteRating(r);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
