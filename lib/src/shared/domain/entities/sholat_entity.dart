// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SholatEntity extends Equatable {
  final bool status;
  final DataSholatEntity data;

  const SholatEntity({required this.status, required this.data});
  @override
  List<Object?> get props => [status, data];
}

class DataSholatEntity extends Equatable {
  final int id;
  final String lokasi;
  final String daerah;
  final List<JadwalDataSholatEntity> jadwal;
  const DataSholatEntity({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.jadwal,
  });

  @override
  List<Object> get props => [id, lokasi, daerah, jadwal];
}

class JadwalDataSholatEntity extends Equatable {
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

  const JadwalDataSholatEntity({
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
}
