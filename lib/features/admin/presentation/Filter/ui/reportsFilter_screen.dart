import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/features/admin/presentation/Filter/logic/report_filter_cubit.dart';

class reportsFilterScreen extends StatefulWidget {

  @override
  State<reportsFilterScreen> createState() => _reportsFilterScreenState();
}

class _reportsFilterScreenState extends State<reportsFilterScreen> {

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
           body: Container(
             alignment: Alignment.center,
             child:InkWell(
               child: Text('length  ${(context.read<ReportFilterCubit>().reports??[]).length.toString()}',),
               onTap: (){
                 context.read<ReportFilterCubit>().getReports();
               },
             ),
           ),
         );
      }));
    });
  }
  
}