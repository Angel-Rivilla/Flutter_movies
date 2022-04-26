import 'package:application_movies/models/models.dart';
import 'package:application_movies/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie ;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar( movie: movie ),
          SliverList(
            delegate: SliverChildListDelegate([
                MoviePosterTitle( movie: movie ),
                MovieOverview( movie: movie ),
                CastingCards( movieId: movie.id )
            ])
          )
        ],
      )
    );
  }
}