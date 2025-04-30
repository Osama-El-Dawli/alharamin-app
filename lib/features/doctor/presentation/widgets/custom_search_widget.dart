import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key, required this.onSearch});
  final void Function(String) onSearch;

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onSearch(_controller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _controller,
            hintText: 'Search',
            prefixIcon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppColors.lightGrey,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: AppColors.primary,
          ),
          onPressed: () {
            widget.onSearch(_controller.text.trim());
          },
        ),
      ],
    );
  }
}
