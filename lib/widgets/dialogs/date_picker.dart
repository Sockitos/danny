import 'package:animations/animations.dart';
import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/dialogs/list_ratings.dart';
import 'package:danny/widgets/dialogs/rating_details.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.events,
  }) : super(key: key);

  final Map<DateTime, List<Rating>> events;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime selectedDay;
  VoidCallback? callback;

  @override
  void initState() {
    super.initState();
    var date = DateTime.now();
    date = DateTime(date.year, date.month, date.day);
    selectedDay = date;
    final ratings = widget.events[date] ?? [];
    if (ratings.isNotEmpty) {
      callback = () => showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                ratings.length > 1
                    ? ListRatings(ratings: ratings)
                    : RatingDetails(rating: ratings.first),
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black12,
            transitionDuration: const Duration(milliseconds: 300),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeScaleTransition(animation: animation, child: child);
            },
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kbackground,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorders.borderM,
      ),
      child: Stack(
        children: <Widget>[
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Select a Date',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: AppColors.ksecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  child: TableCalendar<Rating>(
                    firstDay: DateTime(2010),
                    focusedDay: selectedDay,
                    lastDay: DateTime(2030, 12, 31, 23, 59, 59),
                    eventLoader: (date) => widget.events[date] ?? [],
                    selectedDayPredicate: (date) =>
                        date.year == selectedDay.year &&
                        date.month == selectedDay.month &&
                        date.day == selectedDay.day,
                    rowHeight: 48,
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.ksecondary,
                      ),
                      leftChevronIcon: Icon(
                        CustomIcons.arrow_left,
                        color: AppColors.kprimary,
                        size: 18,
                      ),
                      rightChevronIcon: Icon(
                        CustomIcons.arrow_right,
                        color: AppColors.kprimary,
                        size: 18,
                      ),
                      formatButtonVisible: false,
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: AppColors.ksecondary.withOpacity(0.5),
                      ),
                      weekendStyle: const TextStyle(
                        color: AppColors.kprimary,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      weekendTextStyle:
                          const TextStyle(color: AppColors.kprimary),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                      todayTextStyle: const TextStyle(color: Colors.white),
                      outsideTextStyle: TextStyle(
                        color: AppColors.ksecondary.withOpacity(0.25),
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: AppColors.kprimary,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: AppColors.kprimary.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: const BoxDecoration(
                        color: AppColors.kprimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return Positioned(
                            right: 2.5,
                            top: 2.5,
                            child: _buildEventsMarker(date, events),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    onDaySelected: (date, _) {
                      selectedDay = date;
                      final ratings = widget.events[date] ?? [];
                      if (ratings.isNotEmpty) {
                        setState(() {
                          callback = () => showGeneralDialog(
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ratings.length > 1
                                            ? ListRatings(ratings: ratings)
                                            : RatingDetails(
                                                rating: ratings.first,
                                              ),
                                barrierDismissible: true,
                                barrierLabel: MaterialLocalizations.of(context)
                                    .modalBarrierDismissLabel,
                                barrierColor: Colors.black12,
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                transitionBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeScaleTransition(
                                    animation: animation,
                                    child: child,
                                  );
                                },
                              );
                        });
                      } else {
                        setState(() {
                          callback = () {};
                        });
                      }
                    },
                  ),
                ),
              ),
              GenericButton(
                title: 'Show Details',
                onPressed: callback ?? () {},
              ),
              const SizedBox(height: 30)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: date.year == selectedDay.year &&
                date.month == selectedDay.month &&
                date.day == selectedDay.day
            ? AppColors.ksecondary
            : date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day
                ? AppColors.ksecondary
                : AppColors.kprimary,
      ),
      width: 15,
      height: 15,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
