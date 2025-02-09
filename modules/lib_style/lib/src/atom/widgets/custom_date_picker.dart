import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lib_common/lib_common.dart';

import '../../../lib_style.dart';
import 'svg_image_widget.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.isStartDate,
    required this.onPressed,
    required this.firstDate,
    required this.lastDay,
    this.currentDate,
  });

  final bool isStartDate;
  final void Function(DateTime?) onPressed;
  final DateTime firstDate;
  final DateTime lastDay;
  final DateTime? currentDate;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate = DateTime.now();
  final Resources res = getIt<Resources>();
  String _selectedValue = '';
  int countForwardMovement = 0;
  DateTime _currentMonth = DateTime.now();
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    _selectedValue = res.string.today;
    _selectedDate = widget.currentDate ?? DateTime.now();
    _currentDate = widget.currentDate ?? _selectedDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 200), () {
        StatusBarHandler().updateStatusBarWithColor(
          Colors.transparent,
        );
      });
    });
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(minWidth: 396),
        decoration: BoxDecoration(
          color: res.themes.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            if (widget.isStartDate)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: _CustomButton(
                      buttonLebels: <String>[
                        res.string.today,
                        res.string.nextMonday,
                      ],
                      onFirstTap: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                          _selectedValue = res.string.today;
                        });
                      },
                      onSecondTap: () {
                        final int add =
                            (DateTime.sunday - DateTime.now().weekday) + 1;
                        setState(() {
                          _selectedDate =
                              DateTime.now().add(Duration(days: add));
                          _selectedValue = res.string.nextMonday;
                        });
                      },
                      selectedValue: _selectedValue,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16,
                    ),
                    child: _CustomButton(
                      buttonLebels: <String>[
                        res.string.nextTuesday,
                        res.string.after1Week,
                      ],
                      onFirstTap: () {
                        final int add =
                            (DateTime.sunday - DateTime.now().weekday) + 2;
                        setState(() {
                          _selectedDate =
                              DateTime.now().add(Duration(days: add));
                          _selectedValue = res.string.nextTuesday;
                        });
                      },
                      onSecondTap: () {
                        setState(() {
                          _selectedDate =
                              DateTime.now().add(const Duration(days: 7));
                          _selectedValue = res.string.after1Week;
                        });
                      },
                      selectedValue: _selectedValue,
                    ),
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: _CustomButton(
                  buttonLebels: <String>[
                    res.string.noDate,
                    res.string.today,
                  ],
                  onFirstTap: () {
                    setState(() {
                      _selectedDate = null;
                      _selectedValue = res.string.noDate;
                    });
                  },
                  selectedValue: _selectedValue,
                  onSecondTap: () {
                    setState(() {
                      _selectedDate = DateTime.now();
                      _selectedValue = res.string.today;
                    });
                  },
                ),
              ),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                firstDate: widget.firstDate,
                lastDate: widget.lastDay,
                currentDate: _currentDate,
                weekdayLabelTextStyle: res.themes.bodySmall,
                calendarType: CalendarDatePicker2Type.single,
                dayTextStyle: res.themes.bodySmall,
                selectedYearTextStyle: res.themes.titleLarge
                    .copyWith(color: res.themes.lightBlack),
                customModePickerIcon: const SizedBox.shrink(),
                controlsTextStyle: res.themes.titleLarge.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
                lastMonthIcon: Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: SvgPicture.asset(
                    leftForwardIcon,
                    height: 24,
                    width: 24,
                    colorFilter: _currentMonth.isBefore(_currentDate) && !widget.isStartDate
                        ? null
                        : ColorFilter.mode(
                            res.themes.lightGrey,
                            BlendMode.srcIn,
                          ),
                  ),
                ),
                nextMonthIcon: const Padding(
                  padding: EdgeInsets.only(right: 70.0),
                  child: SvgImageWidget(
                    svgImage: rightForwardIcon,
                    height: 24,
                    width: 24,
                  ),
                ),
                modePickersGap: 0.0,
                centerAlignModePicker: true,
                weekdayLabels: <String>[
                  'Sun',
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                ],
              ),
              onDisplayedMonthChanged: (DateTime newMonth) {
                setState(() {
                  _currentMonth = newMonth;
                });
              },
              value: <DateTime?>[_selectedDate ?? DateTime.now()],
              onValueChanged: (List<DateTime> dates) {
                if (dates.isEmpty) {
                  return;
                }
                final DateTime selectedDate = dates.first;
                if (selectedDate == null) {
                  return;
                }
                setState(() {
                  _selectedDate = selectedDate;
                });
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 0.4,
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SvgImageWidget(
                          svgImage: calenderIcon,
                          height: 23,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            _selectedDate != null
                                ? DateFormat(dateFormat)
                                    .format(_selectedDate ?? DateTime.now())
                                : res.string.noDate,
                            style: res.themes.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          backgroundColor: res.themes.lightBlue,
                        ),
                        onPressed: () => getIt<NavigationService>().goBack(),
                        child: Text(
                          res.string.cancel,
                          style: res.themes.bodyLarge.copyWith(
                            color: res.themes.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          backgroundColor: res.themes.blue,
                        ),
                        onPressed: () => widget.onPressed(_selectedDate),
                        child: Text(
                          res.string.save,
                          style: res.themes.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    required this.buttonLebels,
    required this.onFirstTap,
    required this.onSecondTap,
    this.selectedValue = '',
  });

  final List<String> buttonLebels;
  final VoidCallback onFirstTap;
  final VoidCallback onSecondTap;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    final Resources res = getIt<Resources>();
    final bool isFirstSelected = buttonLebels.first == selectedValue;
    final bool isSecondSelected = buttonLebels.last == selectedValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              backgroundColor:
                  isFirstSelected ? res.themes.blue : res.themes.lightBlue,
            ),
            onPressed: onFirstTap,
            child: Text(
              buttonLebels.first,
              style: res.themes.displayMedium.copyWith(
                color: isFirstSelected ? res.themes.white : res.themes.blue,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              backgroundColor:
                  isSecondSelected ? res.themes.blue : res.themes.lightBlue,
            ),
            onPressed: onSecondTap,
            child: Text(
              buttonLebels.last,
              style: res.themes.displayMedium.copyWith(
                color: isSecondSelected ? res.themes.white : res.themes.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
