import 'package:application_movies/models/models.dart';
import 'package:application_movies/providers/movies_provider.dart';
import 'package:application_movies/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon( Icons.clear )
      )
    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
      onPressed: () => close(context, null), 
      icon: const Icon( Icons.arrow_back )
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    
    return const Text('buildResults');
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty ){
      return const EmptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>( context, listen: false );
    moviesProvider.getSuggestionsByQuery( query );
    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) {
        
        if( !snapshot.hasData ) return const EmptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, index) => MovieItem( movie: movies[index] ),
        );
      },
    );
  }
}