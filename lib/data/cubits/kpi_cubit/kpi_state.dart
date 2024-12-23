import '../../models/kpiInfo.dart';
import '../../models/kpi_model.dart';

abstract class KpiState {}

class KpiInitial extends KpiState {}

class KpiLoading extends KpiState {}

class KpiLoaded extends KpiState {
  final List<KpiInfo> kpis;

  KpiLoaded(this.kpis);
}

class KpiError extends KpiState {
  final String message;

  KpiError(this.message);
}
