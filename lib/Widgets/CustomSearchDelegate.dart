import 'package:flutter/material.dart';
import '../APIRequests/homeOwnerSearchAPI.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<String> suggestionNames;
  final Function(List<Map<String, dynamic>>, String) onSearchResults;
  final String initialQuery;

  CustomSearchDelegate({
    required this.suggestionNames,
    required this.onSearchResults,
    required this.initialQuery,
  });


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      // If the query is empty, display suggestion names
      return ListView.builder(
        itemCount: suggestionNames.length,
        itemBuilder: (context, index) {
          var result = suggestionNames[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              query = result;
              showResults(context);
            },
          );
        },
      );
    }

    // If there is a non-empty query, perform the search
    return FutureBuilder(
      future: HomeOwnerSearchAPI.searchServiceProvidersByName(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error ?? "Unknown error"}');
        } else {
          List<Map<String, dynamic>> searchResults =
              snapshot.data as List<Map<String, dynamic>>;

          Future.microtask(() {
            close(context, null); // Close the search bar
            onSearchResults(searchResults, query); // Pass the query
          });

          // Return an empty container as results are displayed in the SearchPage
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = suggestionNames
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;
            showResults(context);
          },
        );
      },
    );
  }
}
