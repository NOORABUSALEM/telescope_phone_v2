class ApiConstants {

  static const String baseUrl = 'http://192.168.1.101:3000/api/v2';
  static const String users = '$baseUrl/users';
  static const String kpis = '$baseUrl/kpis';

  static const String loginEndpoint = '$users/login';
  static const String getAllkpisEndpoint = '$kpis/mobileApp/getAllaccessibleKpi';

// static const kpiInfo = "$baseUrl/kpi/info";
  // static const kpiDailyData = "$baseUrl/kpi/data/daily/LatestDailyRecord";
  // static const latestSevenRecords =
  //     "$baseUrl/kpi/data/daily/LatestSevenRecords";
  // static const lastUpdate = "$baseUrl/kpi/data/daily/lastUpdate";
}
