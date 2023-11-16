import 'package:flutter/material.dart';


class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [];  // here we will get random first names of the service providers (distinct names)

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: (){
          query = '' ;
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: (){
        close(context , null) ;
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> matchQuery = [] ;
    for (var providerName in searchTerms){
      if(providerName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(providerName) ;
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context , index){
        var result = matchQuery[index] ;
        return ListTile(
          title: Text(result),
        );
      }
    ) ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [] ;
    for (var providerName in searchTerms){
      if(providerName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(providerName) ;
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context , index){
          var result = matchQuery[index] ;
          return ListTile(
            title: Text(result),
          );
        }
    ) ;
  }
  
}