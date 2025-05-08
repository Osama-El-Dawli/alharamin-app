import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMe extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const RememberMe({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant RememberMe oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _isChecked = widget.initialValue;
      });
    }
  }

  void _handleTap() {
    final newValue = !_isChecked;
    setState(() {
      _isChecked = newValue;
    });
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            hoverColor: AppColors.primary,
            activeColor: AppColors.primary,
            value: _isChecked,
            onChanged: (value) {
              if (value != null && value != _isChecked) {
                _handleTap();
              }
            },
          ),
          Text('Remember me', style: Styles.font14W400Grey),
        ],
      ),
    );
  }
}
