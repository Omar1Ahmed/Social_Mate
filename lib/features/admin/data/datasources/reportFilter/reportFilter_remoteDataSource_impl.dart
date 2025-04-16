import 'package:social_media/core/network/dio_client.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/admin/data/models/main_report_model.dart';
import 'package:social_media/features/admin/domain/datasources/reportFilter/reportFilter_remoteDataSource.dart';

class reportFilterRemoteDataSourceImpl implements ReportFilterRemoteDataSource {
  final DioClient dio;
  final userMainDetailsCubit userMainDetails;

  reportFilterRemoteDataSourceImpl({required this.dio, required this.userMainDetails});

  @override
  Future<MainReportModel> getReports({Map<String, dynamic>? queryParams}) async {

    try {
      final response = await dio.get(
        "/reports?",
        header: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userMainDetails.state.token}',
        },
        queryParameters: {

          ...?queryParams
        }
      );

      return MainReportModel.fromJson(response);
    } catch (e) {
      throw Exception("Error fetching posts: ${e.toString()}");
    }

  }


}