part of 'surat_bloc.dart';

sealed class SuratEvent extends Equatable {
  const SuratEvent();
}

class SuratGetEvent extends SuratEvent {
  const SuratGetEvent();

  @override
  List<Object> get props => [];
}

class SuratGetDetailEvent extends SuratEvent {
  final int id;

  const SuratGetDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
