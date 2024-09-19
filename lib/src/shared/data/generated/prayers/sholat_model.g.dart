// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/prayers/sholat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SholatModel _$SholatModelFromJson(Map<String, dynamic> json) => SholatModel(
      status: json['status'] as bool,
      data: DataSholatModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SholatModelToJson(SholatModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

DataSholatModel _$DataSholatModelFromJson(Map<String, dynamic> json) =>
    DataSholatModel(
      id: (json['id'] as num).toInt(),
      lokasi: json['lokasi'] as String,
      daerah: json['daerah'] as String,
      jadwal: (json['jadwal'] as List<dynamic>)
          .map((e) => JadwalDataSholatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataSholatModelToJson(DataSholatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lokasi': instance.lokasi,
      'daerah': instance.daerah,
      'jadwal': instance.jadwal.map((e) => e.toJson()).toList(),
    };

JadwalDataSholatModel _$JadwalDataSholatModelFromJson(
        Map<String, dynamic> json) =>
    JadwalDataSholatModel(
      tanggal: json['tanggal'] as String,
      imsak: json['imsak'] as String,
      subuh: json['subuh'] as String,
      terbit: json['terbit'] as String,
      dhuha: json['dhuha'] as String,
      dzuhur: json['dzuhur'] as String,
      ashar: json['ashar'] as String,
      maghrib: json['maghrib'] as String,
      isya: json['isya'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$JadwalDataSholatModelToJson(
        JadwalDataSholatModel instance) =>
    <String, dynamic>{
      'tanggal': instance.tanggal,
      'imsak': instance.imsak,
      'subuh': instance.subuh,
      'terbit': instance.terbit,
      'dhuha': instance.dhuha,
      'dzuhur': instance.dzuhur,
      'ashar': instance.ashar,
      'maghrib': instance.maghrib,
      'isya': instance.isya,
      'date': instance.date,
    };
