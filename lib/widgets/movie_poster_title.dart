import 'package:application_movies/models/models.dart';
import 'package:flutter/material.dart';

class MoviePosterTitle extends StatelessWidget {

  final Movie movie;
  
  const MoviePosterTitle({
    Key? key, 
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of( context ).size;

    return Container(
      margin: const EdgeInsets.only( top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Row(children: [
        Hero(
          tag: movie.heroId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage( movie.getFullPosterImg ),
              height: 150
            ),
          ),
        ),

        const SizedBox( width: 20 ),

        ConstrainedBox(
          constraints: BoxConstraints( maxWidth: size.width - 190 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2 ),
              Text( movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis ),
              Row(
                children: [
                  const Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                  const SizedBox( width: 5 ),
                  Text( '${movie.voteAverage}', style: textTheme.caption )
                ],
              )
            ],
          ),
        )
      ],),
    );
  }
}