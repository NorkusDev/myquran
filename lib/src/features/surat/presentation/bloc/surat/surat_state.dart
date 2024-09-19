part of 'surat_bloc.dart';

enum StatusSurat { initial, loading, success, failed }

class SuratState extends Equatable {
  final String message;
  final StatusSurat status;
  final List<SuratEntity>? surat;
  final AyatEntity? ayat;

  const SuratState(
      {this.message = '',
      this.status = StatusSurat.initial,
      this.surat,
      this.ayat});

  @override
  List<Object?> get props => [message, status, surat, ayat];

  SuratState copyWith({
    String? message,
    StatusSurat? status,
    List<SuratEntity>? surat,
    AyatEntity? ayat,
  }) {
    return SuratState(
      message: message ?? this.message,
      status: status ?? this.status,
      surat: surat ?? this.surat,
      ayat: ayat ?? this.ayat,
    );
  }
}

extension StatusSuratX on StatusSurat {
  bool get init => this == StatusSurat.initial;
  bool get load => this == StatusSurat.loading;
  bool get suc => this == StatusSurat.success;
  bool get fail => this == StatusSurat.failed;
}
