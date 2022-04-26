import 'package:application_movies/models/models.dart';
import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {

  final Movie movie;

  const MovieOverview({
    Key? key, 
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of( context ).textTheme.subtitle1,
      )
    );
  }
}