
import 'package:application_movies/models/models.dart';
import 'package:application_movies/providers/movies_provider.dart';
import 'package:application_movies/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards({
    Key? key,
    required this.movieId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast( movieId ),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapshot) {

        if( !snapshot.hasData ) {
          return Container(
            constraints: const BoxConstraints( maxWidth: 150 ),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only( bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CastCard( cast: cast[index] )
          ),
        );

      }
    );
  }
}
