import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
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
          onPressed: () {},
        ),
      ],
    );
  }
}
