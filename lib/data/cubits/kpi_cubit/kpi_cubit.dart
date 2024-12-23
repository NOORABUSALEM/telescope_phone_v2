
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telescope_phone_v2/data/models/kpi_model.dart';

import '../../models/kpiInfo.dart';
import '../../repos/kpiInfo_repository.dart';
import '../../repos/kpi_repository.dart';
import 'kpi_state.dart';

class KpiCubit extends Cubit<KpiState> {
  final KpiInfoRepository repository;
  List<KpiInfo> _allKpis = []; // Store all KPIs

  KpiCubit(this.repository) : super(KpiInitial());

  Future<void> fetchKpis() async {
    emit(KpiLoading());
    try {
      final kpis = await repository.getAllKpis();
      _allKpis = kpis; // Save the fetched KPIs
      emit(KpiLoaded(kpis));
    } catch (e) {
      emit(KpiError("Failed to load KPIs"));
    }
  }

  List<KpiInfo> getDailyKpis() {
    // Filter daily KPIs from the fetched KPIs
    return _allKpis.where((kpi) => kpi.status == 'success').toList();
  }
}
