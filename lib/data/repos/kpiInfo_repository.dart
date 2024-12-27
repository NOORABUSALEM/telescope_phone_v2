
import '../models/kpiInfo.dart';
import '../providers/kpiinfo_providers.dart';

class KpiInfoRepository {
  final KpiInfoProvider Provider;

  KpiInfoRepository( this.Provider);

  Future<List<KpiInfo>> fetch() async {
    final apiData = await Provider.getKpiList() as List<KpiInfo>;

      if (apiData != null && apiData.isNotEmpty) {
        print('API Response: $apiData');
        print('apiData runtime type: ${apiData.runtimeType}');
        return apiData;
      } else {
        return [];
      }
    }
}
