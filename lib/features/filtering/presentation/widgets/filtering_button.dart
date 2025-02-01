import 'package:flutter/material.dart';
import 'package:social_media/core/theming/colors.dart';


class FilteringButton extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onPressed;
  const FilteringButton({
    super.key, required this.screenWidth, required this.screenHeight, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(screenWidth,
                screenHeight * 0.05),
          ),
          backgroundColor:
              MaterialStateProperty.all(ColorsManager.primaryColor),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
        ),
        child: Text(
          'Filter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
