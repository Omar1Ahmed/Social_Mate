import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';

class CommentCard extends StatelessWidget {
  DeviceInfo info;

  CommentCard({required this.info,super.key});

  @override
  Widget build(BuildContext context) {

    return Align(
        alignment: Alignment.center,
        child: Container(
          width: info.screenWidth * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: info.screenHeight* 0.13,
                ),
                margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(info.screenWidth * 0.07),
                    bottomLeft: Radius.circular(info.screenWidth * 0.07),
                    bottomRight: Radius.circular(info.screenWidth * 0.07),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.blackColor.withOpacity(0.35),
                      blurRadius: info.screenWidth * 0.05,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [



                    Row(
                      children: [
                        Container(
                          height: info.screenHeight * 0.05,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Omar',
                                style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.035,color: ColorsManager.blackColor, fontWeight: FontWeight.w800),
                              ),

                              Text(
                                '2025-01-01 10:00 AM',
                                style: TextStyles.inter18Regularblack.copyWith(fontSize: info.screenWidth * 0.035,color: ColorsManager.greyColor, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                        ),
                        Spacer(),
                        if(true)
                          IconButton(
                            onPressed: () {
                              final postId = 1;
                              if (postId == 0) {
                                return;
                              }
                              // _showDeleteConfirmationDialog(context, postId);

                            },
                            icon: Icon(
                              Icons.close,
                              color: ColorsManager.redColor.withOpacity(0.7),
                              size: info.screenWidth * 0.07,
                            ),
                          )
                      ],
                    ),
                    SizedBox(height: info.localHeight * 0.01),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.03,bottom: info.screenHeight * 0.013),
                      child: Text(
                        'kajsdnflksmflasdjnf',
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
                      ),
                    )

                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.03),
                child: Row(
                  children: [
                    Text('0',style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04,)),

                    IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up_alt_outlined, color: ColorsManager.primaryColor, size: info.screenWidth * 0.06,)),
                    Text('0',style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.thumb_down_alt_outlined, color: ColorsManager.redColor, size: info.screenWidth * 0.06,)),
                    Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Icons.flag, color: ColorsManager.redColor, size: info.screenWidth * 0.06,)),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

}