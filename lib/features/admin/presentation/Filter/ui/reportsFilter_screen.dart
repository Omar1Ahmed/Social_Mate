import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/widgets/header_widget.dart';
import 'package:social_media/features/admin/presentation/Filter/logic/report_filter_cubit.dart';
import 'package:social_media/features/admin/presentation/all_reports/ui/widgets/main_report_card.dart';

class reportsFilterScreen extends StatefulWidget {

  @override
  State<reportsFilterScreen> createState() => _reportsFilterScreenState();
}

class _reportsFilterScreenState extends State<reportsFilterScreen> {
  bool _isExpanded = true;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd'); // Date format
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    context.read<ReportFilterCubit>().getReports();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = _dateFormat.format(pickedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return SafeArea(
          child: BlocConsumer<ReportFilterCubit, ReportFilterState>(
          listener: (context, state) {

      }, builder: (context, state){
            var reports = context.watch<ReportFilterCubit>().reports ?? [];
            var cubit = context.read<ReportFilterCubit>();
            return Scaffold(
           body: Column(
             mainAxisAlignment: MainAxisAlignment.start,

             children: [
                HeaderWidget(
                   isAdmin: false,
                   isUser: false,
                   extraButtons: [],
                   isBackButtonVisible: true,
                   info: info,
                   onBackPressed: () => context.pop(),
                   titleImageAsset: 'assets/images/Title_img.png',
                 ),

               Container(
                 alignment: AlignmentDirectional.centerStart,
                 padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05),
                 child: Text('Filter Reports', style: TextStyle(fontWeight: FontWeight.bold, fontSize: info.screenWidth * 0.05,),textAlign: TextAlign.start,),
               ),

               Container(
                  margin: EdgeInsetsDirectional.only(top: info.screenHeight* 0.01),
                 width: info.screenWidth * 0.85,
                 clipBehavior: Clip.antiAlias,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(info.screenWidth * 0.05),

                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                       spreadRadius: info.screenWidth * 0.01,
                       blurRadius: info.screenWidth * 0.01,
                       offset: const Offset(0, 3),
                     ),
                   ],
                 ),
                 child: ExpansionPanelList(

                   expandedHeaderPadding: EdgeInsets.all(info.screenWidth*0.01),
                   expansionCallback: (panelIndex, isExpanded) {
                     setState(() {
                       _isExpanded = !_isExpanded;
                     });
                   },
                   children: [
                     ExpansionPanel(
                       isExpanded: _isExpanded,
                       headerBuilder: (context, isExpanded) {
                         return ListTile(
                           title: Text('Filter Options', style: TextStyle(fontWeight: FontWeight.bold)),
                         );
                       },
                       body: Padding(
                         padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.04, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                         child: Column(
                           children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(

                                  child: DropdownButton<int>(
                                    isExpanded: true,

                                    value: cubit.statusId,
                                    hint: Text('Status'),
                                    onChanged: (value) {
                                      setState(() => cubit.statusId = value);
                                    },
                                    items: [
                                      DropdownMenuItem(value: 1, child: Text('Pending')),
                                      DropdownMenuItem(value: 2, child: Text('Approved')),
                                      DropdownMenuItem(value: 3, child: Text('Cascaded Approval')),
                                      DropdownMenuItem(value: 4, child: Text('Rejected')),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  // width: info.screenWidth * 0.4,
                                  child: DropdownButton<int>(
                                    value: cubit.categoryId,
                                    isExpanded: true,
                                    hint: Text('Category'),
                                    onChanged: (value) {
                                      setState(() => cubit.categoryId = value);
                                    },
                                    items: [
                                      DropdownMenuItem(value: 1, child: Text('Spam')),
                                      DropdownMenuItem(value: 2, child: Text('Copyright Violation')),
                                      DropdownMenuItem(value: 3, child: Text('False Information')),
                                    ],
                                  ),
                                )
                              ],
                            ),

                             SizedBox(height: info.screenHeight*0.01),

                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                   width: info.screenWidth * 0.3,
                                   child: TextField(
                                     controller: fromDateController,
                                     decoration: InputDecoration(
                                       labelText: 'From Date',
                                       suffixIcon: IconButton(
                                         icon: Icon(Icons.calendar_today),
                                         onPressed: () => _selectDate(context, fromDateController),
                                       ),
                                     ),
                                     readOnly: true,
                                   ),
                                 ),

                                 Container(
                                   width: info.screenWidth * 0.3,
                                   child: TextField(
                                   controller: toDateController,
                                   decoration: InputDecoration(
                                     labelText: 'To Date',
                                     suffixIcon: IconButton(
                                       icon: Icon(Icons.calendar_today),
                                       onPressed: () => _selectDate(context, toDateController),
                                     ),
                                   ),
                                   readOnly: true,
                                 ),
                                  ),
                               ],
                             ),
                             SizedBox(height: info.screenHeight*0.01),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Expanded(
                                   child: DropdownButton<String>(
                                     isExpanded: true,
                                     value: cubit.orderBy,
                                     hint: Text('Order By'),
                                     onChanged: (value) {
                                       setState(() => cubit.orderBy = value.toString());
                                     },
                                     items: [
                                       DropdownMenuItem(value: 'REPORT_CATEGORY', child: Text('Report Category')),
                                       DropdownMenuItem(value: 'REPORT_STATUS', child: Text('Report Status')),
                                       DropdownMenuItem(value: 'CREATION_DATE', child: Text('Creation Date')),
                                     ],
                                   ),
                                 ),

                                 Expanded(

                                   child: DropdownButton<String>(
                                     isExpanded: true,
                                     value: cubit.orderDir,
                                     hint: Text('Order Direction'),
                                     onChanged: (value) {
                                       setState(() => cubit.orderDir = value.toString());
                                     },
                                     items: [
                                       DropdownMenuItem(value: 'ASC', child: Text('Ascending')),
                                       DropdownMenuItem(value: 'DESC', child: Text('Descending')),
                                     ],
                                   ),
                                 ),

                               ],
                             ),


                             ElevatedButton(
                               onPressed: () {
                                 cubit.applyFilter(
                                   fromDateController.text,
                                   toDateController.text,
                                 );

                               },
                               child: Text('Apply Filter'),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),

                SizedBox(height: info.screenHeight*0.01,),
                Expanded(
                  child: reports.isEmpty
                      ? Center(child: Text('No reports available'))
                      : ListView.builder(
                    itemCount: reports.length,
                    padding: EdgeInsetsDirectional.only(start: info.screenWidth*0.02, end: info.screenWidth*0.02),
                    itemBuilder: (context, index) {
                      return MainReportCard(
                        deviceInfo: info,
                        postTitle: reports[index].postTitle,
                        reportedBy: reports[index].reportedBy,
                        postId: reports[index].postId,
                        reportDate: reports[index].reportedOn,
                        reportCategory: reports[index].category,
                        reportStatus: reports[index].status,
                        reportId: reports[index].reportId,
                      );
                    },
                  ),
                )

                  ],
           )
         );
      }));
    });
  }
  
SliverToBoxAdapter _buildHeader(DeviceInfo info) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.all(info.screenWidth * 0.05),
      child: HeaderWidget(
        isAdmin: false,
        isUser: false,
        extraButtons: [],
        isBackButtonVisible: true,
        info: info,
        onBackPressed: () => context.pop(),
        titleImageAsset: 'assets/images/Title_img.png',
      ),
    ),
  );
}
}

