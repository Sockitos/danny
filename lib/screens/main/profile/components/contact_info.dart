import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/cupertino.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need help?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.kprimary,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                CustomIcons.mail,
                size: 16,
                color: AppColors.kprimary,
              ),
              const SizedBox(width: 8),
              Text(
                'jrnogueira@edu.ulisboa.pt',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ksecondary.withOpacity(0.5),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                CustomIcons.phone,
                size: 16,
                color: AppColors.kprimary,
              ),
              const SizedBox(width: 8),
              Text(
                '+351 962 017 320',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ksecondary.withOpacity(0.5),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
