class KpiInfo {
  String? status;
  List<Data>? data;

  KpiInfo({this.status, this.data});

  KpiInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? nameEn;
  String? nameAr;
  String? type;
  String? unit;
  String? periodicity;
  bool? positiveDirection;
  List<Null>? relatedKpis;
  String? descriptionEn;
  String? descriptionAr;
  String? formula;

  Data(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.type,
        this.unit,
        this.periodicity,
        this.positiveDirection,
        this.relatedKpis,
        this.descriptionEn,
        this.descriptionAr,
        this.formula});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['nameEn'];
    nameAr = json['nameAr'];
    type = json['type'];
    unit = json['unit'];
    periodicity = json['periodicity'];
    positiveDirection = json['positiveDirection'];
    if (json['relatedKpis'] != null) {
      relatedKpis = <Null>[];
      // json['relatedKpis'].forEach((v) {
      //   relatedKpis!.add(new Null.fromJson(v));
      // });
    }
    descriptionEn = json['descriptionEn'];
    descriptionAr = json['descriptionAr'];
    formula = json['formula'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameEn'] = this.nameEn;
    data['nameAr'] = this.nameAr;
    data['type'] = this.type;
    data['unit'] = this.unit;
    data['periodicity'] = this.periodicity;
    data['positiveDirection'] = this.positiveDirection;
    if (this.relatedKpis != null) {
     // data['relatedKpis'] = this.relatedKpis!.map((v) => v.toJson()).toList();
    }
    data['descriptionEn'] = this.descriptionEn;
    data['descriptionAr'] = this.descriptionAr;
    data['formula'] = this.formula;
    return data;
  }
}