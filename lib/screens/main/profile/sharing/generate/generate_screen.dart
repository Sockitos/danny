import 'package:danny/constants/colors.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/screens/main/profile/sharing/generate/components/selectable_tracker.dart';
import 'package:danny/screens/main/profile/sharing/generate/generation_screen.dart';
import 'package:danny/services/background_service.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/utils/date_utils.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/buttons/goback_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/notifications/error_notification.dart';
import 'package:danny/widgets/range_selector.dart';
import 'package:danny/widgets/switcher.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({Key? key}) : super(key: key);

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  bool type = true;
  late Range range;
  List<String> options = [];
  Map<String, bool> selected = {};

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    range = getWeekRange();
    super.initState();
  }

  void changeRange(Range newRange) {
    setState(() => range = newRange);
  }

  void changeType(bool option) {
    setState(() {
      type = option;
      if (type) {
        range = getWeekRange();
      } else {
        range = getMonthRange();
      }
    });
  }

  void _selectOption(String option) {
    selected[option] = !(selected[option] ?? false);
    setState(() {});
  }

  bool _isSelected(String option) => selected[option] ?? false;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final trackers = db.userTrackersStream();

    return Scaffold(
      backgroundColor: AppColors.kbackground,
      body: SafeArea(
        child: Stack(
          children: [
            const GoBackButton(),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const DannyAvatar(),
                  const SizedBox(height: 20),
                  const Text(
                    'Sharing is Caring',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ksecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Let's choose what we want to share..",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ksecondary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Switcher(callback: changeType, light: false),
                  RangeSelector(
                    type: type,
                    range: range,
                    changeType: changeType,
                    changeRange: changeRange,
                    light: false,
                  ),
                  Expanded(
                    child: StreamBuilder<List<Tracker>>(
                      stream: trackers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final selectables = snapshot.data!;
                          options = selectables.map((s) => s.id).toList();
                          options.insert(0, 'Well-Being');

                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: selectables.length + 1,
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? SelectableTracker(
                                      tracker: 'Well-Being',
                                      selected: _isSelected('Well-Being'),
                                      callback: _selectOption,
                                    )
                                  : SelectableTracker(
                                      tracker: selectables[index - 1].id,
                                      selected: _isSelected(
                                        selectables[index - 1].id,
                                      ),
                                      callback: _selectOption,
                                    );
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  GenericButton(
                    title: 'Generate',
                    onPressed: () async {
                      final opts = <String>[];
                      for (final o in options) {
                        if (selected[o] ?? false) opts.add(o);
                      }

                      if (opts.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.white,
                            content: ErrorNotification('No trackers selected'),
                          ),
                        );
                        return;
                      }
                      Provider.of<BackgroundService>(context, listen: false)
                          .incGenerated();
                      await Navigator.push(
                        context,
                        PageTransition<void>(
                          type: PageTransitionType.fade,
                          child: GenerationScreen(
                            type: type,
                            range: range,
                            options: opts,
                          ),
                        ),
                      );
                      Navigator.pop(context, true);
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
