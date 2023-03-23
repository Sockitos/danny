import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class ProfileNickname extends StatefulWidget {
  const ProfileNickname({
    Key? key,
    required this.nickname,
    required this.callback,
  }) : super(key: key);

  final String nickname;
  final Function callback;

  @override
  _ProfileNicknameState createState() => _ProfileNicknameState();
}

class _ProfileNicknameState extends State<ProfileNickname> {
  bool _isEditingText = false;
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.nickname);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isEditingText
        ? TextField(
            onSubmitted: (value) {
              widget.callback(value, null, context);
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  _isEditingText = false;
                });
              });
            },
            textInputAction: TextInputAction.done,
            controller: _ctrl,
            autofocus: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.ksecondary,
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  widget.nickname,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ksecondary,
                  ),
                ),
              ),
              Positioned(
                right: -5,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  onTap: () {
                    setState(() {
                      _isEditingText = true;
                    });
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(8),
                    color: Colors.transparent,
                    child: const Icon(
                      CustomIcons.pencil,
                      size: 20,
                      color: AppColors.kprimary,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
