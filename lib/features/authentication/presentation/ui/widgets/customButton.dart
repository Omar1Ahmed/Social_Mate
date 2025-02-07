import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, minimumSize:  Size(double.infinity, info.screenHeight * 0.057),
        elevation: info.screenWidth * 0.016,


        ),
        child: Text(text, style:  TextStyle(color: Colors.white,fontSize: info.screenWidth * 0.04, fontWeight: FontWeight.bold)),
      );
    });
  }
}