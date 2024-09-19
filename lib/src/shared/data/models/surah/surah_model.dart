import 'package:json_annotation/json_annotation.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/quran/surat_entity.dart';

part '../../generated/surah/surah_model.g.dart';

@JsonSerializable()
class SurahModel
    with
        JsonSerializableMixin<SurahModel>,
        MapperEntity<SurahModel, SuratEntity> {
  final int nomor;
  final String nama;
  @JsonKey(name: 'nama_latin')
  final String latin;
  @JsonKey(name: 'jumlah_ayat')
  final int jumlahAyat;
  @JsonKey(name: 'tempat_turun')
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audio;

  const SurahModel({
    required this.nomor,
    required this.nama,
    required this.latin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  @override
  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);

  @override
  SurahModel fromJson(Map<String, dynamic> json) => _$SurahModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SurahModelToJson(this);

  @override
  SuratEntity toEntity() => SuratEntity(
      nomor: nomor,
      nama: nama,
      latin: latin,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurun,
      arti: arti,
      deskripsi: deskripsi,
      audio: audio);
}
