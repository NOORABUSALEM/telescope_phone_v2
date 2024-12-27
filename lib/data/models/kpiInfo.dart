import 'package:flutter/cupertino.dart';

import 'kpiData_model.dart';

class KpiInfoListModel {
  List<KpiInfo>? kpiInfo;

  KpiInfoListModel({this.kpiInfo});

  factory KpiInfoListModel.fromJson(Map<String, dynamic> json) {
    // Safeguard for unexpected `data` format
    if (json['data'] is! List) {
      throw FormatException('Unexpected data format: Expected a list but got ${json['data'].runtimeType}');
    }

    return KpiInfoListModel(
      kpiInfo: (json['data'] as List<dynamic>)
          .map((e) => KpiInfo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': kpiInfo?.map((e) => e.toJson()).toList(),
    };
  }
}
class KpiInfo {
  String? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? type;
  num? target;
  String? auth;
  bool? notification;
  bool? positiveDirection; // Updated field name
  String? kpiUnit;
  String? source;
  String? periodicity; // New field
  List<RelatedKpi>? relatedKpis;
  KpiData? kpiData;

  KpiInfo({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.type,
    this.target,
    this.auth,
    this.notification,
    this.positiveDirection,
    this.kpiUnit,
    this.source,
    this.periodicity, // New field
    this.relatedKpis,
    this.kpiData,
  });

  factory KpiInfo.fromJson(Map<String, dynamic> json) {
    return KpiInfo(
      id: json['id'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      type: json['type'] as String?,
      target: json['target'] as num?,
      auth: json['auth'] as String?,
      notification: json['notification'] as bool?,
      positiveDirection: json['positiveDirection'] as bool?, // Map the new field
      kpiUnit: json['unit'] as String?,
      source: json['source'] as String?,
      periodicity: json['periodicity'] as String?, // Map the new field
      relatedKpis: (json['relatedKpis'] as List<dynamic>?)
          ?.map((e) => RelatedKpi.fromJson(e))
          .toList(),
      kpiData: json['kpiData'] != null
          ? KpiData.fromJson(json['kpiData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'type': type,
      'target': target,
      'auth': auth,
      'notification': notification,
      'positiveDirection': positiveDirection, // Serialize the new field
      'unit': kpiUnit,
      'source': source,
      'periodicity': periodicity, // Serialize the new field
      'relatedKpis': relatedKpis?.map((e) => e.toJson()).toList(),
      'kpiData': kpiData?.toJson(),
    };
  }

  String getLocalizedName(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? (nameAr ?? '') : (nameEn ?? '');
  }

  String getLocalizedDescription(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar'
        ? (descriptionAr ?? '')
        : (descriptionEn ?? '');
  }

}

class RelatedKpi {
  String? id;
  String? nameAr;
  String? nameEn;

  RelatedKpi({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  String getLocalizedName(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    if (locale.languageCode == 'ar') {
      return nameAr ?? '';
    } else {
      return nameEn ?? '';
    }
  }
  factory RelatedKpi.fromJson(Map<String, dynamic> json) {
    return RelatedKpi(
      id: json['_id'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }
}
