import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateSelectorListView extends StatefulWidget {
  const DateSelectorListView({super.key});

  @override
  DateSelectorListViewState createState() => DateSelectorListViewState();
}

class DateSelectorListViewState extends State<DateSelectorListView> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;

  final double itemWidth = 50.w;
  final double selectedItemWidth = 60.w;
  final double itemSpacing = 12;
  final int itemCount = 6;

  void _scrollToCenter(int index) {
    final totalItemWidth = itemWidth + itemSpacing;
    final screenWidth = MediaQuery.of(context).size.width;
    final targetOffset =
        (totalItemWidth * index) - (screenWidth / 2 - selectedItemWidth / 2);

    _scrollController.animateTo(
      targetOffset.clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _selectAndScrollTo(int index) {
    if (index < 0 || index >= itemCount) return;
    setState(() {
      selectedIndex = index;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(index);
    });
  }

  void _scrollLeft() {
    _selectAndScrollTo(selectedIndex - 1);
  }

  void _scrollRight() {
    _selectAndScrollTo(selectedIndex + 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == itemCount - 1 ? 0 : itemSpacing.w,
                  ),
                  child: GestureDetector(
                    onTap: () => _selectAndScrollTo(index),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: isSelected ? 65.h : 55.h,
                        width: isSelected ? selectedItemWidth.w : itemWidth.w,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primary
                                  : AppColors.lighterGrey,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Wed',
                              style:
                                  isSelected
                                      ? Styles.font16W600White
                                      : Styles.font14W500LightGrey,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '20',
                              style:
                                  isSelected
                                      ? Styles.font16W600White
                                      : Styles.font14W500LightGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Left iOS-style Arrow
          Positioned(
            left: -7.w,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _scrollLeft,
              child: Container(
                padding: EdgeInsets.all(8.w),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          // Right iOS-style Arrow
          Positioned(
            right: -7.w,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _scrollRight,
              child: Container(
                padding: EdgeInsets.all(8.w),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
