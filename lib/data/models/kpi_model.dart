// class Kpi {
//   String? status;
//   List<Data>? data;
//
//   Kpi({this.status, this.data});
//
//   Kpi.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   Main? main;
//   Record? record;
//   Info? info;
//
//   Data({this.main, this.record, this.info});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     main = json['main'] != null ? new Main.fromJson(json['main']) : null;
//     record =
//     json['record'] != null ? new Record.fromJson(json['record']) : null;
//     info = json['info'] != null ? new Info.fromJson(json['info']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.main != null) {
//       data['main'] = this.main!.toJson();
//     }
//     if (this.record != null) {
//       data['record'] = this.record!.toJson();
//     }
//     if (this.info != null) {
//       data['info'] = this.info!.toJson();
//     }
//     return data;
//   }
// }
//
// class Main {
//   String? id;
//   String? nameEn;
//   String? nameAr;
//   String? type;
//   String? unit;
//   String? periodicity;
//   bool? positiveDirection;
//
//   Main(
//       {this.id,
//         this.nameEn,
//         this.nameAr,
//         this.type,
//         this.unit,
//         this.periodicity,
//         this.positiveDirection});
//
//   Main.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameEn = json['nameEn'];
//     nameAr = json['nameAr'];
//     type = json['type'];
//     unit = json['unit'];
//     periodicity = json['periodicity'];
//     positiveDirection = json['positiveDirection'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['nameEn'] = this.nameEn;
//     data['nameAr'] = this.nameAr;
//     data['type'] = this.type;
//     data['unit'] = this.unit;
//     data['periodicity'] = this.periodicity;
//     data['positiveDirection'] = this.positiveDirection;
//     return data;
//   }
// }
//
// class Record {
//   Value? value;
//
//   Record({this.value});
//
//   Record.fromJson(Map<String, dynamic> json) {
//     value = json['value'] != null ? new Value.fromJson(json['value']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.value != null) {
//       data['value'] = this.value!.toJson();
//     }
//     return data;
//   }
// }
//
// class Value {
//   String? date;
//   int? data;
//
//   Value({this.date, this.data});
//
//   Value.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     data = json['data'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['data'] = this.data;
//     return data;
//   }
// }
//
// class Info {
//   String? descriptionEn;
//   String? descriptionAr;
//   String? formula;
//
//   Info({this.descriptionEn, this.descriptionAr, this.formula});
//
//   Info.fromJson(Map<String, dynamic> json) {
//     descriptionEn = json['descriptionEn'];
//     descriptionAr = json['descriptionAr'];
//     formula = json['formula'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['descriptionEn'] = this.descriptionEn;
//     data['descriptionAr'] = this.descriptionAr;
//     data['formula'] = this.formula;
//     return data;
//   }
// }