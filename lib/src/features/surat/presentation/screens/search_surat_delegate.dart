import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/quran/ayat_entity.dart';

class SearchSuratDelegate extends SearchDelegate<DataAyatEntity> {
  final List<DataAyatEntity> searchList;

  SearchSuratDelegate(this.searchList);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
