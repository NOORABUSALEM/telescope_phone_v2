part of 'kpi_info_cubit.dart';

// Define States for the Cubit
@immutable
abstract class KpiInfoState extends Equatable {}

final class KpiInfoInitial extends KpiInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class KpiInfoLoading extends KpiInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class KpiInfoSuccess extends KpiInfoState {
  final List<KpiInfo> kpiList;

  KpiInfoSuccess(this.kpiList);

  @override
  List<Object?> get props => [kpiList];
}

final class KpiInfoError extends KpiInfoState {
  final String message;

  KpiInfoError(this.message);

  @override
  List<Object?> get props => [message];
}
