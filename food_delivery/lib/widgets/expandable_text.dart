import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text, required});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  // This variables will hold the first and second parts of the text.
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    // Check if text length is more than textheight required.
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.8,
              color: AppColors.paraColor,
              text: firstHalf,
              size: Dimensions.font16,
            )
          : Column(
              children: [
                SmallText(
                    height: 1.8,
                    color: AppColors.paraColor,
                    size: Dimensions.font16,
                    text: hiddenText
                        ? ('$firstHalf...')
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.width20,
                      bottom: Dimensions.height20,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          hiddenText
                              ? SmallText(
                                  size: Dimensions.font18,
                                  text: "Show more",
                                  color: AppColors.mainColor,
                                )
                              : SmallText(
                                  size: Dimensions.font18,
                                  text: "Show less",
                                  color: AppColors.mainColor,
                                ),
                          Icon(
                            hiddenText
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: AppColors.mainColor,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
