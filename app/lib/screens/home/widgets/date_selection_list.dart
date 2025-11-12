import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:aero/formatters/time.dart';

class DateSelectionList extends StatelessWidget {
  final Function(DateTime date) onDateSelected;

  const DateSelectionList({
    super.key,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final date = DateTime.now();
        if (index == 0) {
          return ListTile(
            title: Text("Today"),
            leading: Icon(Icons.calendar_month),
            subtitle: Text(formatDayAndMonth(date)),
            onTap: () => onDateSelected(date),
          );
        } else if (index == 1) {
          final tmrh = DateTime(date.year, date.month, date.day + 1);
          return ListTile(
            title: Text("Tomorrow"),
            leading: Icon(MdiIcons.calendarArrowRight),
            subtitle: Text(formatDayAndMonth(tmrh)),
            onTap: () => onDateSelected(tmrh),
          );
        } else {
          final yesterday = DateTime(date.year, date.month, date.day - 1);
          return ListTile(
            title: Text("Yesterday"),
            leading: Icon(MdiIcons.calendarArrowLeft),
            subtitle: Text(formatDayAndMonth(yesterday)),
            onTap: () => onDateSelected(yesterday),
          );
        }
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 3,
    );
  }
}

