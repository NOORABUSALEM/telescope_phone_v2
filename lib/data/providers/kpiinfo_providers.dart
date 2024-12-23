import 'package:dio/dio.dart';
import '../../core/constants/constants.dart';
import '../../core/services/auth_service.dart';
import '../models/kpiInfo.dart';
import '../models/kpi_model.dart';

class KpiInfoProvider {
  late Dio dio;
  late AuthService authService;

  KpiInfoProvider() {
    dio = Dio(BaseOptions(baseUrl: ApiConstants.kpis));
    authService = AuthService();
  }

  Future<List<KpiInfo>> fetchKpisInfo() async {
    try {
      // Get the token from AuthService
      final token = await authService.getToken();

      if (token == null) {
        throw Exception('User token is missing. Please log in.');
      }

      // Add the token to the request header
      dio.options.headers['Authorization'] = 'Bearer $token';
      print('Token added to request header: $token');

      // Make the request
      final response = await dio.get(ApiConstants.getAllkpisEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('Fetched data: $data');
        return data.map((json) => KpiInfo.fromJson(json)).toList();
      } else {
        print('Failed to fetch KPIs. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch KPIs');
      }
    } catch (e) {
      print('Error fetching KPIs: $e');
      throw Exception('Error fetching KPIs: $e');
    }
  }
}
