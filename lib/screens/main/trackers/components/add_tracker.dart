import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTracker extends StatefulWidget {
  const AddTracker({Key? key}) : super(key: key);

  @override
  _AddTrackerState createState() => _AddTrackerState();
}

class _AddTrackerState extends State<AddTracker> {
  String dropdownValue = 'Custom';
  String customValue = 'Custom';

  DropdownButton _dropdown(List<Tracker> recommendations) {
    final items = ['Custom'];
    for (final tracker in recommendations) {
      items.add(tracker.id);
    }
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 2,
      style: TextStyle(
        color: AppColors.ksecondary.withOpacity(0.5),
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Quicksand',
      ),
      underline: const SizedBox(),
      onChanged: (newValue) {
        if (newValue == null) return;
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    final recommendations = database.trackersStream();

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
          Container(
            height: 540,
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'New Tracker',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 4),
                Text(
                  'Select a recommended tracker',
                  style: TextStyle(
                    color: AppColors.ksecondary.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(flex: 2),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  color: AppColors.ksecondary.withOpacity(0.05),
                  child: StreamBuilder<List<Tracker>>(
                    stream: recommendations,
                    initialData: const [],
                    builder: (context, snapshot) {
                      return _dropdown(snapshot.data ?? []);
                    },
                  ),
                ),
                const Spacer(flex: 3),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        indent: 30,
                        thickness: 1.5,
                        color: AppColors.ksecondary.withOpacity(0.1),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: AppColors.ksecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 30,
                        thickness: 1.5,
                        color: AppColors.ksecondary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Text(
                  'Create your own',
                  style: TextStyle(
                    color: AppColors.ksecondary.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    enabled: dropdownValue == 'Custom',
                    onChanged: (value) {
                      customValue = value;
                      if (customValue == '') customValue = 'Custom';
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    style: TextStyle(
                      color: AppColors.ksecondary.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    cursorColor: AppColors.ksecondary.withOpacity(0.5),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      fillColor: AppColors.ksecondary.withOpacity(0.05),
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Name your tracker..',
                      hintStyle: TextStyle(
                        color: dropdownValue == 'Custom'
                            ? AppColors.ksecondary.withOpacity(0.5)
                            : AppColors.ksecondary.withOpacity(0.2),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 4),
                GenericButton(
                  title: 'Add Tracker',
                  onPressed: () async {
                    final tracker =
                        dropdownValue == 'Custom' ? customValue : dropdownValue;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('configUpdated', false);
                    await database.setUserTracker(
                      Tracker(id: tracker),
                    );
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
