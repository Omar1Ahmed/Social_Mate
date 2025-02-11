import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';
import 'package:social_media/features/admin/data/datasources/all_reports_remote_source.dart';
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';
import 'package:social_media/features/admin/domain/repositories/main_report_repo.dart';

class MainReportRepoImpl implements MainReportRepo{
  final AllReportsRemoteSource allReportsRemoteSource;
  MainReportRepoImpl({required this.allReportsRemoteSource});
  @override
  Future<List<MainReportEntity>> getAllReports(Map<String, dynamic> queryParams, {required String token}) async{
    bool isConnected = await ConnectivityHelper.isConnected();
    
    if(isConnected){
      try{
        final reportModels = await allReportsRemoteSource.getAllReports(queryParams, token: token);
        return reportModels.expand((model) => model.toReportEntities()).toList();
      }catch(e){
        throw Exception('Failed to fetch reports in repo: $e');
      }
    }else{
      throw Exception('No internet connection');
    }
  }
}