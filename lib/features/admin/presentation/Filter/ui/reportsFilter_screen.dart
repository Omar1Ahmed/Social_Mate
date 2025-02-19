import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/widgets/header_widget.dart';
import 'package:social_media/features/admin/presentation/Filter/logic/report_filter_cubit.dart';

class reportsFilterScreen extends StatefulWidget {

  @override
  State<reportsFilterScreen> createState() => _reportsFilterScreenState();
}

class _reportsFilterScreenState extends State<reportsFilterScreen> {
  bool _isExpanded = true;
  @override
  void initState() {
    super.initState();
    context.read<ReportFilterCubit>().getReports();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return SafeArea(
          child: BlocConsumer<ReportFilterCubit, ReportFilterState>(
          listener: (context, state) {

      }, builder: (context, state){
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

                 width: info.screenWidth * 0.8,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(info.screenWidth * 0.05),
                 ),
                 child: ExpansionPanelList(
                   expandedHeaderPadding: EdgeInsets.all(0),
                   expansionCallback: (panelIndex, isExpanded) {
                     setState(() {
                       _isExpanded = !_isExpanded;
                     });
                   },
                   children: [
                     ExpansionPanel(
                       isExpanded: _isExpanded,
                       backgroundColor: Colors.white,
                       canTapOnHeader: true,
                       headerBuilder: (context, isExpanded) {
                         return ListTile(
                           title: Text('Filter Options', style: TextStyle(fontWeight: FontWeight.bold)),
                         );
                       },
                       body: Padding(
                         padding: EdgeInsets.all(10),
                         child: Column(
                           children: [
                             // 🔹 Example Filter Options
                             DropdownButton<String>(
                               // value: context.read<ReportFilterCubit>().selectedFilter,
                               hint: Text('Select Report Type'),
                               onChanged: (value) {
                                 // context.read<ReportFilterCubit>().setFilter(value);
                               },
                               items: ['Spam', 'Abuse', 'Other'].map((String category) {
                                 return DropdownMenuItem<String>(
                                   value: category,
                                   child: Text(category),
                                 );
                               }).toList(),
                             ),
                             SizedBox(height: 10),
                             ElevatedButton(
                               onPressed: () {
                                 // context.read<ReportFilterCubit>().applyFilter();
                               },
                               child: Text('Apply Filter'),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ],
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

