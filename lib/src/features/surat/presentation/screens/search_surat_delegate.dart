import 'package:flutter/material.dart';

import '../../../../core/constant/theme/app_colors.dart';
import '../../../../core/constant/theme/app_theme.dart';
import '../../../../shared/data/datasource/theme/local_data_source.dart';
import '../../../../shared/domain/entities/quran/ayat_entity.dart';

class SearchSuratDelegate extends SearchDelegate<DataAyatEntity> {
  final List<DataAyatEntity> searchList;
  final ThemeType themeType;

  SearchSuratDelegate(this.searchList, this.themeType);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppTheme.darkTheme.copyWith(
      appBarTheme: AppBarTheme(
        color: AppTheme.mode(context).isDark
            ? AppColors.darkBackgroundColor
            : AppColors.lightBackgroundColor,
      ),
    );
  }

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        color: themeType.isDark
            ? AppColors.lightBackgroundColor
            : AppColors.textPrimaryColor,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // When pressed here the query will be cleared from the search bar.
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<DataAyatEntity> searchResults = searchList
        .where(
          (item) =>
              item.idn.toLowerCase().contains(query.toLowerCase()) ||
              item.nomor.toString().contains(
                    query.toString(),
                  ),
        )
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].idn),
          onTap: () {
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<DataAyatEntity> searchResults = searchList
        .where(
          (item) =>
              item.idn.toLowerCase().contains(query.toLowerCase()) ||
              item.nomor.toString().contains(
                    query.toString(),
                  ),
        )
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].idn),
          onTap: () {
            // context.router.push(AyatRoutes(index: index));
            close(context, searchResults[index]);
          },
        );
      },
    );
  }
}
