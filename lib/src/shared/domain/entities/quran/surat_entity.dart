import 'package:equatable/equatable.dart';

class SuratEntity extends Equatable {
  final int nomor;
  final String nama;

  final String latin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audio;

  const SuratEntity({
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
  List<Object> get props => [
        nomor,
        nama,
        latin,
        jumlahAyat,
        tempatTurun,
        arti,
        deskripsi,
        audio,
      ];
}
