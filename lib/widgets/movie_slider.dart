import 'package:application_movies/models/models.dart';
import 'package:application_movies/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;
  
  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage,
    this.title
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() { 
      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }

    });
  }

  @override
  void dispose() {

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity ,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          if( widget.title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20),
              child: Text(widget.title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
            ),

          const SizedBox( height: 5 ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, index) => MoviePoster( movie: widget.movies[index], heroId: '${ widget.title }-$index-${ widget.movies[index].id }', ),
            ),
          ),

        ],
      ),
    );
  }
}
