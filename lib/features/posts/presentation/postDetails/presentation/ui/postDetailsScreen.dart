import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/Shimmer/ShimmerStyle.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/shared/show_report_post_dialog_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/ui/widgets/CommentCard.dart';

class post_details_screen extends StatefulWidget {
  @override
  State createState() => _post_details_screenState();
}

class _post_details_screenState extends State<post_details_screen> {
  final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();

  @override
  void initState() {
    super.initState();
    print('initState');
    context.read<PostDetailsCubit>().getPostDetails();
  }
  @override
  Widget build(BuildContext context) {

    return InfoWidget(builder: (context, info) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: ColorsManager.whiteColor,
        body: BlocConsumer<PostDetailsCubit, PostDetailsState>(listener: (context, state) {

          print('state : $state');

        },
        builder: (context, state) {

          final postDetailsCubit = context.read<PostDetailsCubit>();
          final userMainDetails = context.read<userMainDetailsCubit>();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: info.screenHeight * 0.019),
              child: Column(
                children: [
                  _buildHeader(info, context),
                  Divider(
                    height: info.localHeight * 0.01,
                    thickness: info.screenWidth * 0.001,
                    color: ColorsManager.greyColor,
                  ),

                  Container(
                      width: double.infinity,
                      clipBehavior: Clip.none,
                      constraints: BoxConstraints(
                        minHeight: info.screenHeight* 0.25,
                      ),
                      padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: ColorsManager.whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(info.screenWidth * 0.04),
                          bottomRight: Radius.circular(info.screenWidth * 0.04),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.blackColor.withOpacity(0.35),
                            blurRadius: info.screenWidth * 0.04,
                            spreadRadius: info.screenWidth * 0.0001,

                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(
                                height: info.screenHeight * 0.053,
                                child: state is PostDetailsLoading || state is PostDetailsInitial?
                                customShimmer(
                                  childWidget: Row(children: [
                                    Container(
                                      width: info.screenWidth * 0.4,
                                      height: info.screenHeight * 0.03,

                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(info.screenWidth * 0.04),
                                      ),
                                    ),

                                    Spacer(),

                                    Container(

                                      width: info.screenWidth * 0.09,
                                      height: info.screenHeight * 0.04,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                    ),

                                    Container(
                                      width: info.screenWidth * 0.09,
                                      height: info.screenHeight * 0.04,
                                      margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                    )
                                  ],),)
                                    :

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        postDetailsCubit.post.title.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.042),
                                      ),
                                    ),

                                    if(userMainDetails.state.userId== postDetailsCubit.post.createdBy!.id)
                                      IconButton(
                                        onPressed: () {

                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: ColorsManager.redColor.withOpacity(0.7),
                                          size: info.screenWidth * 0.065,
                                        ),
                                      ),

                                  ],
                                ),
                              ),


                              Divider(
                                color: Colors.black,
                                thickness: info.screenWidth * 0.002,
                                height: info.localHeight * 0.015,
                              ),

                              state is PostDetailsLoading || state is PostDetailsInitial ?
                              customShimmer(
                                  childWidget: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        width: info.screenWidth * 0.25,
                                        height: info.screenHeight * 0.025,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09))
                                      ),

                                      Container(
                                          width: info.screenWidth * 0.27,
                                          height: info.screenHeight * 0.025,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09))
                                      ),
                                    ],
                                  ))
                                  :
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Padding(
                                    padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.015),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          postDetailsCubit.post.createdBy!.fullName.toString(),
                                          style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.04),
                                        ),

                                        Text(
                                          postDetailsCubit.post.FormattedDate.toString(),
                                          style: TextStyles.inter18Regularblack.copyWith(fontSize: info.screenWidth * 0.03),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(

                                      onPressed: (){

                                        showDialog(
                                            context: context,
                                            builder: (context) => ShowReportPostDialogWidget(
                                              deviceInfo: info,
                                            ));
                                        }, icon: Icon(
                                    Icons.flag,
                                    color: ColorsManager.redColor.withOpacity(0.7),
                                    size: info.screenWidth * 0.065,
                                  )),
                                ],
                              ),



                              SizedBox(height: info.localHeight * 0.013),

                              state is PostDetailsLoading || state is PostDetailsInitial ?
                              customShimmer(
                                  childWidget: Column(
                                    spacing: info.screenHeight * 0.01,

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: info.screenHeight * 0.01),
                                      Container(
                                          width: info.screenWidth * 0.75,
                                          height: info.screenHeight * 0.025,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))
                                      ),
                                      Container(
                                          width: info.screenWidth * 0.6,
                                          height: info.screenHeight * 0.025,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))
                                      ),
                                      Container(
                                          width: info.screenWidth * 0.7,
                                          height: info.screenHeight * 0.025,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))
                                      ),
                                      
                                    ],
                                  ) )
                              :
                              Container(
                                width: double.infinity,
                                padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.052, end: info.screenWidth * 0.02,bottom: info.screenHeight * 0.01),

                                child: Text(
                                  context.read<PostDetailsCubit>().post.content ?? 'Empty Content !!!',
                                  textAlign: TextAlign.justify,
                                  softWrap: true,
                                  style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04,color: ColorsManager.blackColor, fontWeight: FontWeight.w500),
                                ),
                              )

                            ],
                          ),

                          Column(
                              children: [
                                Divider(
                                  color: Colors.black,
                                  thickness: info.screenWidth * 0.001,
                                  height: info.localHeight * 0.0061,

                                ),
                                Row(
                                  children: [
                                    Text(
                                      '4 comments',
                                      style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04,color: ColorsManager.greyColor, fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '3.5 Rate ',
                                      style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04,color: ColorsManager.greyColor, fontWeight: FontWeight.w400),
                                    ),

                                  ],
                                ),
                                state is PostDetailsLoading ?
                                customShimmer(
                                    childWidget: Container(
                                      margin: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.01),

                                      width: double.infinity,
                                      height: info.screenHeight * 0.04,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: info.screenWidth * 0.01,
                                        children: [
                                          Container(

                                            width: info.screenWidth * 0.09,
                                            height: info.screenHeight * 0.04,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                          ),
                                          Container(

                                            width: info.screenWidth * 0.09,
                                            height: info.screenHeight * 0.04,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                          ),
                                          Container(

                                            width: info.screenWidth * 0.09,
                                            height: info.screenHeight * 0.04,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                          ),
                                          Container(

                                            width: info.screenWidth * 0.09,
                                            height: info.screenHeight * 0.04,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                          ),
                                          Container(

                                            width: info.screenWidth * 0.09,
                                            height: info.screenHeight * 0.04,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                          ),
                                        ]
                                      ),
                                    ) )
                                    :
                                Container(
                                  margin: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.01),
                                  alignment: Alignment.center,
                                  child: RatingStars(
                                    value: 1,
                                    starBuilder: (index, color) => Icon(
                                      Icons.star,
                                      color: color,
                                      size: info.screenWidth * 0.07,
                                    ),
                                    starCount: 5,
                                    starSize: info.screenWidth * 0.07,
                                    valueLabelVisibility: false,
                                  ),
                                ),
                              ]
                          )
                        ],
                      )
                  ),

                  Container(
                    margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02, start: info.screenWidth * 0.02),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Comments', style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.05,),),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.001),
                    height: info.screenHeight * 0.6,
                    width: info.screenWidth,

                    child: ListView(

                      padding: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.07),
                      children: [

                        CommentCard(info: info,),
                        CommentCard(info: info,),
                        CommentCard(info: info,),
                        CommentCard(info: info,),
                        CommentCard(info: info,),
                        CommentCard(info: info,),
                        CommentCard(info: info,),
                        CommentCard(info: info,),

                      ],
                    ),
                  )



                ],
              ),
            ),
          );
        }),
      ));
    });
  }

  Widget _buildHeader(DeviceInfo deviceInfo, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.localWidth * 0.02,
        vertical: deviceInfo.localHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/Title_img.png',
            width: deviceInfo.localWidth * 0.48,
            height: deviceInfo.localHeight * 0.06,
            fit: BoxFit.contain,
          ),



        ],
      ),
    );
  }
}


