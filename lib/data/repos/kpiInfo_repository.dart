import 'package:telescope_phone_v2/data/models/kpiInfo.dart';

import '../models/kpi_model.dart';
import '../providers/kpi_provider.dart';
import '../providers/kpiinfo_providers.dart';

class KpiInfoRepository {
  final KpiInfoProvider provider;

  KpiInfoRepository({required this.provider});

  Future<List<KpiInfo>> getAllKpis() async {
    try {
      return await provider.fetchKpisInfo();
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }
}
