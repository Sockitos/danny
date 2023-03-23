import 'package:cached_network_image/cached_network_image.dart';
import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/widgets/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RatingImage extends StatelessWidget {
  RatingImage({
    Key? key,
    required this.imageUrl,
    required this.onImageSelected,
  }) : super(key: key);

  final String? imageUrl;
  final ValueChanged<PickedFile> onImageSelected;
  final picker = ImagePicker();

  void _openImage(BuildContext context, String url) {
    Feedback.forTap(context);
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewer(
          imageProvider: CachedNetworkImageProvider(url),
        ),
      ),
    );
  }

  // _selectImage(BuildContext context, FirestoreDatabase db, Rating rating,
  //     int index) async {
  //   var connection = Provider.of<ConnectivityResult>(context, listen: false);
  //   if (connection == ConnectivityResult.mobile ||
  //       connection == ConnectivityResult.wifi) {
  //     var photo = await picker.getImage(source: ImageSource.camera);
  //     var storage = Provider.of<FirebaseStorageService>(context, listen: false);
  //     String userId = Provider.of<FirebaseAuthService>(context, listen: false)
  //         .currentUser
  //         .uid;
  //     String newPhotoUrl = photo != null
  //         ? await storage.uploadRatingImage(
  //             userId, rating.id, File(photo.path), index)
  //         : "";
  //     db.setRating(
  //       Rating(
  //         id: rating.id,
  //         timestamp: rating.timestamp,
  //         tracker: rating.tracker,
  //         rating: rating.rating,
  //         imageUrl1: index == 1 ? newPhotoUrl : rating.imageUrl1,
  //         imageUrl2: index == 2 ? newPhotoUrl : rating.imageUrl2,
  //         imageUrl3: index == 3 ? newPhotoUrl : rating.imageUrl3,
  //       ),
  //     );
  //   }
  // }

  // _deleteImage(
  //     BuildContext context, FirestoreDatabase db, Rating rating, int index) {
  //   Feedback.forTap(context);
  //   db.setRating(
  //     Rating(
  //       id: rating.id,
  //       timestamp: rating.timestamp,
  //       tracker: rating.tracker,
  //       rating: rating.rating,
  //       imageUrl1: index == 1 ? "" : rating.imageUrl1,
  //       imageUrl2: index == 2 ? "" : rating.imageUrl2,
  //       imageUrl3: index == 3 ? "" : rating.imageUrl3,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final db = Provider.of<FirestoreDatabase>(context, listen: false);

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: imageUrl == '' || imageUrl == null
            ? InkWell(
                // onTap: () => _selectImage(context, db, rating, index),
                borderRadius: AppBorders.borderS,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppBorders.borderS,
                    border: Border.all(
                      color: AppColors.ksecondary.withOpacity(0.25),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    CustomIcons.mais,
                    size: 40,
                    color: AppColors.kprimary,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => _openImage(context, imageUrl!),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: imageUrl!,
                      imageBuilder: (context, imageProvider) => DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                          borderRadius: AppBorders.borderS,
                          border: Border.all(
                            color: AppColors.ksecondary.withOpacity(0.25),
                            width: 2,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, dynamic _) => DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: AppBorders.borderS,
                          border: Border.all(
                            color: AppColors.ksecondary.withOpacity(0.25),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          CustomIcons.warning,
                          color: AppColors.kprimary,
                          size: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: GestureDetector(
                        // onTap: () => _deleteImage(context, db, rating, index),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.kprimary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                offset: const Offset(4, 4),
                                color: AppColors.kprimary.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            CustomIcons.trash,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
