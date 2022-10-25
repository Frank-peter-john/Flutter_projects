import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

import 'big_text.dart';
import 'icon_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                ),
              ),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '4.5'),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '1287'),
            SizedBox(width: Dimensions.width10),
            SmallText(text: 'Comments')
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          children: [
            IconTextwidget(
                icon: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            SizedBox(width: Dimensions.height10),
            IconTextwidget(
                icon: Icons.location_on,
                text: '1.7km',
                iconColor: AppColors.mainColor),
            SizedBox(width: Dimensions.height10),
            IconTextwidget(
                icon: Icons.access_time_rounded,
                text: '32min',
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
