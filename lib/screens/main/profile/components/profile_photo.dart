import 'package:cached_network_image/cached_network_image.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.photoUrl,
    required this.callback,
  }) : super(key: key);

  final String photoUrl;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: SizedBox(
            height: 160,
            width: 160,
            child: CachedNetworkImage(
              imageUrl: photoUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(5, 10),
                      color: AppColors.kprimary.withOpacity(0.3),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, dynamic error) => Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(5, 10),
                      color: AppColors.kprimary.withOpacity(0.3),
                    ),
                  ],
                ),
                child: const Icon(
                  CustomIcons.profile,
                  color: AppColors.kprimary,
                  size: 60,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 31,
          right: 31,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            onTap: () async {
              final photo = await picker.pickImage(source: ImageSource.gallery);
              callback('', photo, context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.kprimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: const Offset(8, 8),
                    color: AppColors.kprimary.withOpacity(0.3),
                  ),
                ],
              ),
              child: const Icon(
                CustomIcons.photopencil,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
