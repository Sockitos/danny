import 'dart:io';

import 'package:danny/constants/custom_icons.dart';
import 'package:danny/constants/text_styles.dart';
import 'package:danny/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingNickname extends StatelessWidget {
  const OnboardingNickname({
    Key? key,
    required this.onNameChanged,
    required this.onImageChanged,
    required this.image,
  }) : super(key: key);

  final ValueChanged<String> onNameChanged;
  final ValueChanged<File> onImageChanged;
  final File? image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      onImageChanged(File(pickedImage.path));
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
            'Nice to meet you! What do your friends call you?',
            style: AppTextStyles.textLightM,
          ),
        ),
        const Spacer(flex: 2),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: _pickImage,
          child: Ink(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                image: image == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(image!),
                      ),
              ),
              child: Icon(
                CustomIcons.add_picture,
                color: Colors.white.withOpacity(image == null ? 0.75 : 0.05),
                size: 150,
              ),
            ),
          ),
        ),
        const Spacer(),
        InputField(
          label: 'YOUR NICKNAME',
          hint: 'They call me..',
          keyboard: TextInputType.emailAddress,
          capitalized: true,
          onChanged: onNameChanged,
          max: 16,
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
