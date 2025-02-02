import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';

class post_details_screen extends StatefulWidget{
  @override
  State createState() => _post_details_screenState();
  
}

class _post_details_screenState extends State<post_details_screen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InfoWidget(builder: (context, info) {
      return Scaffold(
        body: Center(child: Text('LOOOOOOOOOOOOOOL!!!!!!!!!1'),),
      );
    });
  }
  
}