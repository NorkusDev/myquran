import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/constant/theme/app_colors.dart';
import '../../../../core/constant/theme/app_theme.dart';
import '../../../../core/routes/app_route.gr.dart';
import '../../../../injection.dart';
import '../../../../shared/features/bloc/theme/theme_bloc.dart';
import '../bloc/surat/surat_bloc.dart';
import '../widgets/loading_list_widget.dart';

@RoutePage()
class SuratScreens extends StatefulWidget implements AutoRouteWrapper {
  const SuratScreens({super.key});

  @override
  State<SuratScreens> createState() => _SuratScreensState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SuratBloc>(
          create: (context) => sl<SuratBloc>(),
          child: this,
        ),
      ],
      child: this,
    );
  }
}

class _SuratScreensState extends State<SuratScreens> {
  @override
  void initState() {
    context.read<SuratBloc>().add(const SuratGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mode(context).isDark
          ? AppColors.darkBackgroundColor
          : AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.mode(context).isDark
            ? AppColors.darkBackgroundColor
            : AppColors.lightBackgroundColor,
        title: Text(
          "MyQuran App",
          style: AppTextStyles.boldLarge.copyWith(
              color: AppTheme.mode(context).isDark
                  ? AppColors.lightBackgroundColor
                  : AppColors.primaryColor,
              fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () => BlocProvider.of<ThemeBloc>(context).add(
              ThemeChangeEvent(),
            ),
            icon: Icon(
              Icons.sunny,
              size: 30,
              color: AppTheme.mode(context).isDark
                  ? AppColors.lightBackgroundColor
                  : AppColors.darkBackgroundColor,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(milliseconds: 100), () {
          context.read<SuratBloc>().add(const SuratGetEvent());
        }),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Assalamu'alaikum",
                  style: AppTextStyles.medium.copyWith(
                      color: AppTheme.mode(context).isDark
                          ? AppColors.textSecondaryColor
                          : AppColors.grayColor,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Norkusm",
                  style: AppTextStyles.boldLarge.copyWith(
                    color: AppTheme.mode(context).isDark
                        ? AppColors.lightBackgroundColor
                        : AppColors.textPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              _lastRead(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Surat",
                  style: AppTextStyles.boldLarge.copyWith(
                    color: AppTheme.mode(context).isDark
                        ? AppColors.lightBackgroundColor
                        : AppColors.primaryColor,
                  ),
                ),
              ),
              _suratContent(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding _suratContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        baseColor: AppTheme.mode(context).isDark
                            ? AppColors.grayColor
                            : Colors.grey.shade300,
                        highlightColor: AppTheme.mode(context).isDark
                            ? AppColors.grayColor.withOpacity(0.7)
                            : Colors.grey.shade100,
                        period: const Duration(
                          milliseconds: 1000,
                        ),
                        child: const LoadingListWidget(),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            );
          }
          if (state.status.suc) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, i) => ListTile(
                onTap: () {
                  context.router.push(AyatRoutes(suratNumber: i + 1));
                },
                trailing: Text(
                  "${state.surat?[i].nama}",
                  style: AppTextStyles.boldLarge.copyWith(
                      color: AppTheme.mode(context).isDark
                          ? AppColors.lightBackgroundColor
                          : AppColors.primaryColor),
                ),
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "${state.surat?[i].nomor}",
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        color: AppTheme.mode(context).isDark
                            ? AppColors.lightBackgroundColor
                            : AppColors.textPrimaryColor,
                      ),
                    ),
                    SvgPicture.asset(
                      "${AppConstant.imageAsset}/border_number.svg",
                    ),
                  ],
                ),
                title: Text(
                  "${state.surat?[i].latin}",
                  style: AppTextStyles.boldLarge.copyWith(
                    fontSize: 16,
                    color: AppTheme.mode(context).isDark
                        ? AppColors.lightBackgroundColor
                        : AppColors.primaryColor,
                  ),
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${state.surat?[i].tempatTurun}",
                      style: AppTextStyles.medium.copyWith(
                          color: AppTheme.mode(context).isDark
                              ? AppColors.textSecondaryColor
                              : AppColors.grayColor,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 04,
                      backgroundColor: AppTheme.mode(context).isDark
                          ? AppColors.textSecondaryColor
                          : AppColors.grayColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${state.surat?[i].jumlahAyat} ayat",
                      style: AppTextStyles.medium.copyWith(
                        color: AppTheme.mode(context).isDark
                            ? AppColors.textSecondaryColor
                            : AppColors.grayColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: state.surat?.length,
            );
          }
          return Center(
            child: Text(state.message),
          );
        },
      ),
    );
  }

  Container _lastRead() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradientSecondary,
            AppColors.gradientPrimary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -20,
            child: SvgPicture.asset(
              "${AppConstant.imageAsset}/quran.svg",
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bookmark_add,
                      color: AppColors.lightBackgroundColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Last Read",
                      style: AppTextStyles.boldMedium.copyWith(
                        color: AppColors.lightBackgroundColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Al - Fatiah",
                  style: AppTextStyles.boldLarge.copyWith(
                    color: AppColors.lightBackgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Ayat No : 1",
                  style: AppTextStyles.regularSmall.copyWith(
                    color: AppColors.lightBackgroundColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
