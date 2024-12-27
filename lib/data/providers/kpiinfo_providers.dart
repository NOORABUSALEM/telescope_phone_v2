import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../models/kpiInfo.dart';

class KpiInfoProvider {
  final Dio client;

  KpiInfoProvider(this.client);

  Future<List<KpiInfo>> getKpiList() async {
    try {
      // Retrieve the token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('user_token');

      if (token == null) {
        print('Token is null. Please log in again.');
        return [];
      }

      // Set Authorization header
      client.options.headers['Authorization'] = 'Bearer $token';

      // Optional: Custom status validation
      client.options.validateStatus = (status) {
        return status != null && status < 500; // Allow all 2xx and 4xx statuses
      };

      // Make the GET request
      final response = await client.get(ApiConstants.getAllkpisEndpoint);

      if (response.statusCode == 401) {
        print('Unauthorized request: 401. Check your token.');
        return [];
      }

      if (response.statusCode == 200) {
        // Check the structure of the response data
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data') &&
            responseData['data'] is List) {
          List<KpiInfo> kpiInfoList = (responseData['data'] as List)
              .map((json) => KpiInfo.fromJson(json))
              .toList();
          print('Fetched ${kpiInfoList.length} KPI(s) successfully.');
          return kpiInfoList;
        } else {
          print('Unexpected data format: ${responseData.runtimeType}');
          return [];
        }
      } else {
        print('Failed to fetch KPIs. Status code: ${response.statusCode}');
        print('Response: ${response.data}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Error response: ${e.response?.data}');
    } catch (e, s) {
      print('Unknown error: $e');
      print(s);
    }

    return [];
  }
}
