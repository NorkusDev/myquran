import 'package:equatable/equatable.dart';

class AyatEntity extends Equatable {
  final bool status;
  final int nomor;
  final String nama;
  final String latin;
  final int jumlahAyat;
  final String lokasi;
  final String arti;
  final String deskripsi;
  final String audio;
  final List<DataAyatEntity> ayat;

  const AyatEntity({
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
  List<Object> get props => [
        status,
        nomor,
        nama,
        latin,
        jumlahAyat,
        lokasi,
        arti,
        deskripsi,
        audio,
        ayat,
      ];
}

class DataAyatEntity extends Equatable {
  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String idn;

  const DataAyatEntity({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.idn,
  });

  @override
  List<Object> get props => [id, surah, nomor, ar, idn];
}
