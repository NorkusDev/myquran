// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/ayat/ayat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyatModel _$AyatModelFromJson(Map<String, dynamic> json) => AyatModel(
      status: json['status'] as bool,
      nomor: (json['nomor'] as num).toInt(),
      nama: json['nama'] as String,
      latin: json['nama_latin'] as String,
      jumlahAyat: (json['jumlah_ayat'] as num).toInt(),
      lokasi: json['tempat_turun'] as String,
      arti: json['arti'] as String,
      deskripsi: json['deskripsi'] as String,
      audio: json['audio'] as String,
      ayat: (json['ayat'] as List<dynamic>)
          .map((e) => DataAyatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AyatModelToJson(AyatModel instance) => <String, dynamic>{
      'status': instance.status,
      'nomor': instance.nomor,
      'nama': instance.nama,
      'nama_latin': instance.latin,
      'jumlah_ayat': instance.jumlahAyat,
      'tempat_turun': instance.lokasi,
      'arti': instance.arti,
      'deskripsi': instance.deskripsi,
      'audio': instance.audio,
      'ayat': instance.ayat,
    };

DataAyatModel _$DataAyatModelFromJson(Map<String, dynamic> json) =>
    DataAyatModel(
      id: (json['id'] as num).toInt(),
      surah: (json['surah'] as num).toInt(),
      nomor: (json['nomor'] as num).toInt(),
      ar: json['ar'] as String,
      idn: json['idn'] as String,
    );

Map<String, dynamic> _$DataAyatModelToJson(DataAyatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surah': instance.surah,
      'nomor': instance.nomor,
      'ar': instance.ar,
      'idn': instance.idn,
    };
