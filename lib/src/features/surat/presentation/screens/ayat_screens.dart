import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/constant/theme/app_colors.dart';
import '../../../../core/constant/theme/app_theme.dart';
import '../../../../injection.dart';
import '../../../../shared/data/datasource/theme/local_data_source.dart';
import '../bloc/surat/surat_bloc.dart';
import '../widgets/loading_list_widget.dart';
import 'search_surat_delegate.dart';

@RoutePage()
class AyatScreens extends StatefulWidget implements AutoRouteWrapper {
  const AyatScreens({this.index = 0, this.suratNumber = 1, super.key});
  final int index;
  final int suratNumber;

  @override
  State<AyatScreens> createState() => _AyatScreensState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SuratBloc>(
      create: (context) => sl<SuratBloc>(),
      child: this,
    );
  }
}

class _AyatScreensState extends State<AyatScreens> {
  final ScrollController _scrollController = ScrollController();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(_scrollListener);
    context.read<SuratBloc>().add(SuratGetDetailEvent(widget.suratNumber));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    final visiblePositions = itemPositionsListener.itemPositions.value;
    final maxVisibleLedge = visiblePositions
        .map((position) => position.itemLeadingEdge)
        .reduce((a, b) => a < b ? a : b);
    final maxVisibleIndex = visiblePositions
        .map((position) => position.index)
        .reduce((a, b) => a < b ? a : b);
    if (maxVisibleIndex >= 0 && maxVisibleLedge < (-0.004)) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SuratBloc, SuratState>(
          builder: (context, state) {
            if (state.status.load) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: 15,
                    color: Colors.grey.shade300,
                  ),
                ),
              );
            }
            if (state.status.suc) {
              return Text(
                state.status.suc
                    ? state.ayat?.latin ?? ""
                    : widget.index.toString(),
                style: AppTextStyles.boldLarge.copyWith(
                  color: AppTheme.mode(context).isDark
                      ? AppColors.lightBackgroundColor
                      : AppColors.primaryColor,
                ),
              );
            }
            return const Text("");
          },
        ),
        actions: [
          BlocBuilder<SuratBloc, SuratState>(
            builder: (context, state) {
              if (state.status.suc) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () async {
                      final delegate = await showSearch(
                        context: context,
                        delegate: SearchSuratDelegate(
                          state.ayat?.ayat ?? [],
                          AppTheme.mode(context).isDark
                              ? ThemeType.dark
                              : ThemeType.light,
                        ),
                      );
                      _itemScrollController.scrollTo(
                        index: delegate!.nomor - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: SvgPicture.asset(
                      "${AppConstant.iconAsset}/search_icon.svg",
                      height: 24,
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<SuratBloc>()
              .add(SuratGetDetailEvent(widget.suratNumber));
        }),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              _headerContent(context),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 90.0,
                  child: BlocBuilder<SuratBloc, SuratState>(
                    builder: (context, state) {
                      if (state.status.load) {
                        return Column(
                          children: [1, 2, 3, 4, 5, 6, 7, 8]
                              .asMap()
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  Shimmer.fromColors(
                                    baseColor: AppColors.loadingPrimary,
                                    highlightColor:
                                        AppColors.loadingSecondColor,
                                    child: const LoadingListWidget(),
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        );
                      }
                      if (state.status.suc) {
                        return ScrollablePositionedList.builder(
                          itemCount: state.ayat?.ayat.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _toolbarContent(index),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${state.ayat?.ayat[index].ar}",
                                  textAlign: TextAlign.right,
                                  style: AppTextStyles.boldLarge.copyWith(
                                    color: AppTheme.mode(context).isDark
                                        ? AppColors.lightBackgroundColor
                                        : AppColors.textPrimaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${state.ayat?.ayat[index].idn}",
                                  style: AppTextStyles.regularSmall.copyWith(
                                    fontSize: 16,
                                    color: AppTheme.mode(context).isDark
                                        ? AppColors.textSecondaryColor
                                        : AppColors.textPrimaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                          itemScrollController: _itemScrollController,
                          itemPositionsListener: itemPositionsListener,
                          physics: const AlwaysScrollableScrollPhysics(),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _toolbarContent(int index) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.mode(context).isDark
              ? const Color(0xFF121931)
              : const Color(0xFFF3F3F4),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppTheme.mode(context).isDark
                ? AppColors.secondaryColor
                : AppColors.primaryColor,
            child: Text(
              "${(index + 1)}",
              style: AppTextStyles.medium.copyWith(
                color: AppColors.lightBackgroundColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.share_outlined,
                color: AppTheme.mode(context).isDark
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.play_arrow_outlined,
                color: AppTheme.mode(context).isDark
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.bookmark_outline,
                color: AppTheme.mode(context).isDark
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _headerContent(BuildContext context) {
    return BlocBuilder<SuratBloc, SuratState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.gradientPrimary,
                AppColors.gradientSecondary,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          // padding: EdgeInsets.only(top: 24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: -30,
                bottom: -40,
                child: Opacity(
                  opacity: 0.2,
                  child: SvgPicture.asset(
                    "${AppConstant.imageAsset}/quran.svg",
                    height: 180,
                  ),
                ),
              ),
              state.status.load
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Shimmer.fromColors(
                        baseColor: AppColors.loadingPrimary,
                        highlightColor: AppColors.loadingSecondColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 15,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              decoration: BoxDecoration(
                                color: AppColors.loadingPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 15,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              decoration: BoxDecoration(
                                color: AppColors.loadingPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 2,
                              child: Divider(
                                color: AppColors.lightBackgroundColor
                                    .withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 15,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              decoration: BoxDecoration(
                                color: AppColors.loadingPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 15,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              decoration: BoxDecoration(
                                color: AppColors.loadingPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              height: 15,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              decoration: BoxDecoration(
                                color: AppColors.loadingPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              height: 15,
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              decoration: BoxDecoration(
                                color: AppColors.loadingPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : state.status.suc
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${state.ayat?.latin}",
                                style: AppTextStyles.boldLarge.copyWith(
                                  color: AppColors.lightBackgroundColor,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${state.ayat?.arti}",
                                style: AppTextStyles.boldLarge.copyWith(
                                  color: AppColors.lightBackgroundColor,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 2,
                                child: Divider(
                                  color: AppColors.lightBackgroundColor
                                      .withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${state.ayat?.lokasi}",
                                    style: AppTextStyles.boldLarge.copyWith(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const CircleAvatar(
                                    radius: 04,
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${state.ayat?.jumlahAyat} Ayat",
                                    style: AppTextStyles.boldLarge.copyWith(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: state.ayat?.nomor == 1 ||
                                        state.ayat?.nomor == 9
                                    ? 0
                                    : 24,
                              ),
                              state.ayat?.nomor == 1 || state.ayat?.nomor == 9
                                  ? Container()
                                  : SvgPicture.asset(
                                      "${AppConstant.imageAsset}/basmalah.svg",
                                    )
                            ],
                          ),
                        )
                      : Container(),
            ],
          ),
        );
      },
    );
  }
}
