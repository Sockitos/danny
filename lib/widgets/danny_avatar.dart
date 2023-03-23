import 'package:danny/constants/borders.dart';
import 'package:danny/services/background_service.dart';
import 'package:danny/widgets/avatar_glow.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DannyAvatar extends StatelessWidget {
  const DannyAvatar({
    Key? key,
    this.glow = false,
    this.active = true,
  }) : super(key: key);

  final bool glow;
  final bool active;
  static bool playing = false;

  Widget _buildAvatar(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderL,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(3, 6),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        color: Colors.white,
      ),
      child: const FlareActor(
        'assets/images/danny.flr',
        animation: 'idle',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: active
          ? () {
              Feedback.forTap(context);
              Provider.of<BackgroundService>(context, listen: false).incDanny();
              Navigator.pushNamed(context, '/weekly');
            }
          : () {},
      child: glow
          ? AvatarGlow(
              endRadius: 60,
              glowColor: const Color(0xFF000000),
              repeatPauseDuration: const Duration(seconds: 2),
              startDelay: const Duration(seconds: 2),
              child: _buildAvatar(context),
            )
          : _buildAvatar(context),
    );
  }
}
