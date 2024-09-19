// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_navbar_bloc.dart';

class BottomNavbarState extends Equatable {
  final int indexPage;
  final bool isVisible;
  const BottomNavbarState({
    this.indexPage = 0,
    this.isVisible = true,
  });
  BottomNavbarState copyWith({
    int? indexPage,
    bool? isVisible,
  }) {
    return BottomNavbarState(
      indexPage: indexPage ?? this.indexPage,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object> get props => [indexPage, isVisible];
}
