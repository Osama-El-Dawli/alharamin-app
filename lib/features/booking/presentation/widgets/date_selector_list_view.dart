import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';

class DateSelectorListView extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DateSelectorListView({super.key, required this.onDateSelected});

  @override
  State<DateSelectorListView> createState() => _DateSelectorListViewState();
}

class _DateSelectorListViewState extends State<DateSelectorListView> {
  late final ScrollController _scrollController;
  late final List<DateTime> _dates;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _dates = _getNext7Days();
    _selectedIndex = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerSelectedDate();
      widget.onDateSelected(_dates[_selectedIndex]);
    });
  }

  List<DateTime> _getNext7Days() {
    final now = DateTime.now();
    return List.generate(
      14,
      (i) => now.add(Duration(days: i)),
    ).where((date) => date.weekday != DateTime.friday).take(6).toList();
  }

  void _selectIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
    widget.onDateSelected(_dates[_selectedIndex]);
    _centerSelectedDate();
  }

  void _centerSelectedDate() {
    final itemWidth = 76.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final offset =
        (itemWidth * _selectedIndex) - (screenWidth / 2 - itemWidth / 2);
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                final date = _dates[index];
                final isSelected = _selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => _selectIndex(index),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primary
                                : AppColors.lighterGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date),
                            style:
                                isSelected
                                    ? Styles.font16W600White
                                    : Styles.font16W500LightGrey,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('d').format(date),
                            style:
                                isSelected
                                    ? Styles.font16W600White
                                    : Styles.font16W500LightGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed:
                  () => _selectIndex(
                    (_selectedIndex - 1).clamp(0, _dates.length - 1),
                  ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed:
                  () => _selectIndex(
                    (_selectedIndex + 1).clamp(0, _dates.length - 1),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
