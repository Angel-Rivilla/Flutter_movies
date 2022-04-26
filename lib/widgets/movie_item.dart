import 'package:flutter/material.dart';

import 'package:application_movies/models/models.dart' show Movie; 

class MovieItem extends StatelessWidget {

  final Movie movie;
  
  const MovieItem({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'swiper-${ movie.id }';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage( movie.getFullPosterImg ),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),

      title: Text( movie.title ),
      subtitle: Text( movie.originalTitle ),
      onTap: () => Navigator.pushNamed( context, 'details', arguments: movie ),
    );
  }
}