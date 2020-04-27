// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reportList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportListResponse _$ReportListResponseFromJson(Map<String, dynamic> json) {
  return ReportListResponse(
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Report.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReportListResponseToJson(ReportListResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
