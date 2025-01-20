import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/info_service.dart';
import '../../models/kpiInfo.dart';
import '../../repos/kpiInfo_repository.dart';

part 'kpi_info_state.dart';

class KpiInfoCubit extends Cubit<KpiInfoState> {
  final KpiInfoRepository _repo ;
  InfoService service = InfoService();
  KpiInfoCubit(this._repo) : super(KpiInfoInitial());

  void fetchKpiInfo() async {
    emit(KpiInfoLoading());


    final result = await _repo.fetch();
    if (result.isEmpty == true) {
      emit(KpiInfoError("Kpi data not found."));
      return;
    }
    try {
      try {
        final firstKpiInfo = result.first as KpiInfo;
        final firstValueData = firstKpiInfo.kpiData?.value;
        if (firstValueData != null) {
          final dateString = firstValueData.date;
          await service.saveDate(dateString); // Save the ISO 8601 date string
        } else {
          debugPrint("No value data found in KpiData.");
        }
      } catch (e) {
        debugPrint("Error extracting date: $e");
      }
      emit(KpiInfoSuccess(result.cast<KpiInfo>()));
    } catch (e) {
      emit(KpiInfoError("Failed to process KPI data: $e"));
    }
  }


}
