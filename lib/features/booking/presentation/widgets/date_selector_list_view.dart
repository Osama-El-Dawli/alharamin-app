import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorListView extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const DateSelectorListView({super.key, required this.onDateSelected});

  List<DateTime> _getNext7Days() {
    DateTime current = DateTime.now();
    List<DateTime> days = [];

    for (int i = 0; days.length < 7; i++) {
      final date = current.add(Duration(days: i));
      if (date.weekday != DateTime.friday) {
        days.add(date);
      }
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final dates = _getNext7Days();

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => onDateSelected(date),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEE').format(date),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(DateFormat('d').format(date)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
