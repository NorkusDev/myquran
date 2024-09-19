import 'package:json_annotation/json_annotation.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/quran/ayat_entity.dart';

part '../../generated/ayat/ayat_model.g.dart';

@JsonSerializable()
class AyatModel
    with JsonSerializableMixin<AyatModel>, MapperEntity<AyatModel, AyatEntity> {
  final bool status;
  final int nomor;
  final String nama;
  @JsonKey(name: 'nama_latin')
  final String latin;
  @JsonKey(name: 'jumlah_ayat')
  final int jumlahAyat;
  @JsonKey(name: 'tempat_turun')
  final String lokasi;
  final String arti;
  final String deskripsi;
  final String audio;
  final List<DataAyatModel> ayat;

  const AyatModel({
    required this.status,
    required this.nomor,
    required this.nama,
    required this.latin,
    required this.jumlahAyat,
    required this.lokasi,
    required this.arti,
    required this.deskripsi,
    required this.audio,
    required this.ayat,
  });

  @override
  factory AyatModel.fromJson(Map<String, dynamic> json) =>
      _$AyatModelFromJson(json);

  @override
  AyatModel fromJson(Map<String, dynamic> json) => _$AyatModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AyatModelToJson(this);

  @override
  AyatEntity toEntity() => AyatEntity(
        status: status,
        nomor: nomor,
        nama: nama,
        latin: latin,
        jumlahAyat: jumlahAyat,
        lokasi: lokasi,
        arti: arti,
        deskripsi: deskripsi,
        audio: audio,
        ayat: ayat.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable(explicitToJson: true)
class DataAyatModel
    with
        JsonSerializableMixin<DataAyatModel>,
        MapperEntity<DataAyatModel, DataAyatEntity> {
  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String idn;

  const DataAyatModel({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.idn,
  });

  @override
  factory DataAyatModel.fromJson(Map<String, dynamic> json) =>
      _$DataAyatModelFromJson(json);

  @override
  DataAyatModel fromJson(Map<String, dynamic> json) =>
      _$DataAyatModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataAyatModelToJson(this);

  @override
  DataAyatEntity toEntity() =>
      DataAyatEntity(id: id, surah: surah, nomor: nomor, ar: ar, idn: idn);
}
