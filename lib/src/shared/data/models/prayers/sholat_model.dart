import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/mixins/json_serializable_mixin.dart';
import '../../../../core/mixins/mapper_mixin.dart';
import '../../../domain/entities/sholat_entity.dart';

part '../../generated/prayers/sholat_model.g.dart';

@JsonSerializable()
class SholatModel extends Equatable
    with
        MapperEntity<SholatModel, SholatEntity>,
        JsonSerializableMixin<SholatModel> {
  final bool status;
  final DataSholatModel data;

  SholatModel({required this.status, required this.data});

  @override
  List<Object?> get props => [data, status];

  @override
  SholatEntity toEntity() =>
      SholatEntity(status: status, data: data.toEntity());

  @override
  factory SholatModel.fromJson(Map<String, dynamic> json) =>
      _$SholatModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SholatModelToJson(this);

  @override
  SholatModel fromJson(Map<String, dynamic> json) =>
      _$SholatModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DataSholatModel extends Equatable
    with
        MapperEntity<DataSholatModel, DataSholatEntity>,
        JsonSerializableMixin<DataSholatModel> {
  final int id;
  final String lokasi;
  final String daerah;
  final List<JadwalDataSholatModel> jadwal;
  const DataSholatModel({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.jadwal,
  });

  @override
  List<Object> get props => [id, lokasi, daerah, jadwal];

  @override
  DataSholatEntity toEntity() => DataSholatEntity(
      id: id,
      lokasi: lokasi,
      daerah: daerah,
      jadwal: jadwal.map((e) => e.toEntity()).toList());

  @override
  factory DataSholatModel.fromJson(Map<String, dynamic> json) =>
      _$DataSholatModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataSholatModelToJson(this);

  @override
  DataSholatModel fromJson(Map<String, dynamic> json) =>
      _$DataSholatModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class JadwalDataSholatModel extends Equatable
    with
        MapperEntity<JadwalDataSholatModel, JadwalDataSholatEntity>,
        JsonSerializableMixin<JadwalDataSholatModel> {
  final String tanggal;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;
  final String date;

  const JadwalDataSholatModel({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.date,
  });

  @override
  List<Object> get props {
    return [
      tanggal,
      imsak,
      subuh,
      terbit,
      dhuha,
      dzuhur,
      ashar,
      maghrib,
      isya,
      date,
    ];
  }

  @override
  JadwalDataSholatEntity toEntity() => JadwalDataSholatEntity(
        tanggal: tanggal,
        imsak: imsak,
        subuh: subuh,
        terbit: terbit,
        dhuha: dhuha,
        dzuhur: dzuhur,
        ashar: ashar,
        maghrib: maghrib,
        isya: isya,
        date: date,
      );

  @override
  factory JadwalDataSholatModel.fromJson(Map<String, dynamic> json) =>
      _$JadwalDataSholatModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JadwalDataSholatModelToJson(this);
  @override
  JadwalDataSholatModel fromJson(Map<String, dynamic> json) =>
      _$JadwalDataSholatModelFromJson(json);
}
