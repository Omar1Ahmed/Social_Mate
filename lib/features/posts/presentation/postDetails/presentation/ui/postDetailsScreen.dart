import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/widgets/Shimmer/ShimmerStyle.dart';
import 'package:social_media/core/shared/widgets/cherryToast/CherryToastMsgs.dart';

import 'package:social_media/core/shared/widgets/show_report_post_dialog_widget.dart';
import 'package:social_media/core/shared/widgets/animation/slide_Transition__widget.dart';
import 'package:social_media/core/shared/widgets/animation/tween_animation_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';
import 'package:social_media/core/shared/widgets/CommentCard.dart';

class post_details_screen extends StatefulWidget {
  @override
  State createState() => _post_details_screenState();
}

class _post_details_screenState extends State<post_details_screen> {
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
          child: BlocConsumer<PostDetailsCubit, PostDetailsState>(listener: (context, state) {
            print('state : $state');

            if (state is PostDetailsLoaded) {
              Future.wait(
                [
                  context.read<PostDetailsCubit>().getPostCommentsCount(),
                  context.read<PostDetailsCubit>().getPostRateAverage(),
                  context.read<PostDetailsCubit>().getPostComments(),
                ],
              );
            }
            if (state is SuccessPostRate) {
              CherryToastMsgs.CherryToastSuccess(
                info: info,
                context: context,
                title: 'Success!!',
                description: 'You Rated The Post Successfully',
              );
            }

            if (state is FailPostRate) {
              CherryToastMsgs.CherryToastError(
                info: info,
                context: context,
                title: 'Failed!!',
                description: 'You Rated The Post Failed',
              );
            }

            if (state is GiveReactionSuccess) {
              CherryToastMsgs.CherryToastSuccess(
                info: info,
                context: context,
                title: 'Success!!',
                description: 'You Reacted To The Comment Successfully',
              );
            }

            if (state is GiveReactionFail) {
              CherryToastMsgs.CherryToastError(
                info: info,
                context: context,
                title: 'Failed!!',
                description: 'You Reacted To The Comment Failed',
              );

            }
          }, builder: (context, state) {
            final postDetailsCubit = context.read<PostDetailsCubit>();
            final userMainDetails = context.read<userMainDetailsCubit>();
            return Scaffold(

              backgroundColor: ColorsManager.whiteColor,
              body: Column(
                children: [
                  Expanded(

                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
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
                                      minHeight: info.screenHeight * 0.25,
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
                                              child: state is PostDetailsLoading || state is PostDetailsInitial
                                                  ? customShimmer(
                                                childWidget: Row(
                                                  children: [
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
                                                      margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                                    )
                                                  ],
                                                ),
                                              )
                                                  : Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      postDetailsCubit.post.title.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.042),
                                                    ),
                                                  ),
                                                  if (userMainDetails.state.userId == postDetailsCubit.post.createdBy!.id)
                                                    IconButton(
                                                      onPressed: () {},
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
                                            state is PostDetailsLoading || state is PostDetailsInitial
                                                ? customShimmer(
                                                childWidget: Column(
                                                  spacing: info.screenHeight * 0.01,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(width: info.screenWidth * 0.27, height: info.screenHeight * 0.023, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09))),
                                                    Container(width: info.screenWidth * 0.22, height: info.screenHeight * 0.018, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09))),
                                                  ],
                                                ))
                                                : Row(
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
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => ShowReportPostDialogWidget(
                                                            deviceInfo: info,
                                                          ));
                                                    },
                                                    icon: Icon(
                                                      Icons.flag,
                                                      color: ColorsManager.redColor.withOpacity(0.7),
                                                      size: info.screenWidth * 0.065,
                                                    )),
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.052, end: info.screenWidth * 0.02, bottom: info.screenHeight * 0.01),
                                              child: state is PostDetailsLoading || state is PostDetailsInitial
                                                  ? customShimmer(
                                                  childWidget: Column(
                                                    spacing: info.screenHeight * 0.01,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02), width: info.screenWidth * 0.75, height: info.screenHeight * 0.022, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                                      Container(width: info.screenWidth * 0.6, height: info.screenHeight * 0.017, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.03))),
                                                      Container(width: info.screenWidth * 0.7, height: info.screenHeight * 0.02, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                                    ],
                                                  ))
                                                  : Text(
                                                context.read<PostDetailsCubit>().post.content ?? 'Empty Content !!!',
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                                style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.038, color: ColorsManager.blackColor, fontWeight: FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(children: [
                                          Divider(
                                            color: Colors.black,
                                            thickness: info.screenWidth * 0.001,
                                            height: info.localHeight * 0.0061,
                                          ),
                                          Row(
                                            children: [
                                              postDetailsCubit.commentsCount == null
                                                  ? customShimmer(
                                                  childWidget: Row(
                                                    spacing: info.screenWidth * 0.01,
                                                    children: [
                                                      Container(width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                                      Container(width: info.screenWidth * 0.1, height: info.screenHeight * 0.02, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025)))
                                                    ],
                                                  ))
                                                  : Text(
                                                '${postDetailsCubit.commentsCount} comments',
                                                style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04, color: ColorsManager.greyColor, fontWeight: FontWeight.w400),
                                              ),
                                              const Spacer(),
                                              postDetailsCubit.RateAverage == null
                                                  ? customShimmer(
                                                  childWidget: Row(
                                                    spacing: info.screenWidth * 0.01,
                                                    children: [
                                                      Container(width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                                      Container(width: info.screenWidth * 0.1, height: info.screenHeight * 0.02, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025)))
                                                    ],
                                                  ))
                                                  : Text(
                                                '${postDetailsCubit.RateAverage} Rate ',
                                                style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04, color: ColorsManager.greyColor, fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          postDetailsCubit.RateAverage == null
                                              ? customShimmer(
                                              childWidget: Container(
                                                margin: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.01),
                                                width: double.infinity,
                                                height: info.screenHeight * 0.04,
                                                child: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: info.screenWidth * 0.01, children: [
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
                                                ]),
                                              ))
                                              : Container(
                                            margin: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.01),
                                            alignment: Alignment.center,
                                            child: RatingStars(
                                              value: postDetailsCubit.SelectedRatingValue ?? 0.0,
                                              onValueChanged: (value) {
                                                postDetailsCubit.setRateAverage(value.toInt());
                                              },
                                              starBuilder: (index, color) => Icon(
                                                Icons.star,
                                                color: color,
                                                size: info.screenWidth * 0.075,
                                              ),
                                              starCount: 5,
                                              starSize: info.screenWidth * 0.075,
                                              valueLabelVisibility: false,
                                            ),
                                          ),
                                        ])
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02, start: info.screenWidth * 0.02),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    'Comments',
                                    style: TextStyles.inter18BoldBlack.copyWith(
                                      fontSize: info.screenWidth * 0.05,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        postDetailsCubit.comments == null
                            ? SliverToBoxAdapter(
                            child: customShimmer(
                                childWidget: Column(children: [
                                  Container(
                                      width: info.screenWidth * 0.9,
                                      height: info.screenHeight * 0.13,
                                      margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                                      padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(info.screenWidth * 0.07),
                                          bottomLeft: Radius.circular(info.screenWidth * 0.07),
                                          bottomRight: Radius.circular(info.screenWidth * 0.07),
                                        ),
                                      )),
                                  SizedBox(
                                    height: info.screenHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                      Container(
                                        width: info.screenWidth * 0.08,
                                        height: info.screenHeight * 0.035,
                                        margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                      ),
                                      Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                      Container(
                                        width: info.screenWidth * 0.08,
                                        height: info.screenHeight * 0.035,
                                        margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                      )
                                    ],
                                  ),
                                  Container(
                                      width: info.screenWidth * 0.9,
                                      height: info.screenHeight * 0.13,
                                      margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                                      padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(info.screenWidth * 0.07),
                                          bottomLeft: Radius.circular(info.screenWidth * 0.07),
                                          bottomRight: Radius.circular(info.screenWidth * 0.07),
                                        ),
                                      )),
                                  SizedBox(
                                    height: info.screenHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                      Container(
                                        width: info.screenWidth * 0.08,
                                        height: info.screenHeight * 0.035,
                                        margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                      ),
                                      Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                      Container(
                                        width: info.screenWidth * 0.08,
                                        height: info.screenHeight * 0.035,
                                        margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                      )
                                    ],
                                  ),
                                  Container(
                                      width: info.screenWidth * 0.9,
                                      height: info.screenHeight * 0.13,
                                      margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                                      padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(info.screenWidth * 0.07),
                                          bottomLeft: Radius.circular(info.screenWidth * 0.07),
                                          bottomRight: Radius.circular(info.screenWidth * 0.07),
                                        ),
                                      )),
                                  SizedBox(
                                    height: info.screenHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                      Container(
                                        width: info.screenWidth * 0.08,
                                        height: info.screenHeight * 0.035,
                                        margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                      ),
                                      Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                      Container(
                                        width: info.screenWidth * 0.08,
                                        height: info.screenHeight * 0.035,
                                        margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                      )
                                    ],
                                  ),
                                ])))
                            : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: postDetailsCubit.comments!.length == 0 ? 1 : postDetailsCubit.comments!.length,
                                (context, index) => postDetailsCubit.comments!.length > 0
                                ? TweenAnimationWidget(
                              index: index,
                              deviceInfo: info,
                              child: SlideTransitionWidget(
                                  child: CommentCard(
                                    comment: postDetailsCubit.comments![index],
                                    info: info,
                                  )),
                            )
                                : Container(
                              margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.08),
                              width: info.screenWidth * 0.6,
                              height: info.screenHeight * 0.3,
                              child: Image.asset('assets/images/noComments.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Container(
                              height: info.screenHeight * 0.076,
                              padding: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.007,top: info.screenHeight * 0.007),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: info.screenWidth * 0.85,
                                    padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04,end: info.screenWidth * 0.01),
                                    child: TextField(
                                      controller: postDetailsCubit.createCommentController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ColorsManager.lightGreyColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(info.screenWidth * 0.05),
                                          borderSide: BorderSide.none
                                        ),
                                        hintText: 'Add comment',

                                      )
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    postDetailsCubit.createComment();
                                  }, icon: Icon(Icons.send,
                                    color: ColorsManager.primaryColor,
                                    size: info.screenWidth * 0.08,))
                                ],
                              ),
                            )
                ],
              ),
            );
          }));
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
          // IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     size: deviceInfo.screenWidth * 0.08,
          //     color: ColorsManager.primaryColor,
          //   ),
          //   onPressed: () => context.pop(),
          //   style: ElevatedButton.styleFrom(
          //     shape: const CircleBorder(),
          //     padding: EdgeInsets.all(deviceInfo.screenWidth * 0.02),
          //     backgroundColor: ColorsManager.lightGreyColor,
          //     shadowColor: Colors.transparent,
          //   ),
          // ),
        ],
      ),
    );
  }
}
