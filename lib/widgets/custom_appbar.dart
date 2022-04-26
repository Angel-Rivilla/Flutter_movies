import 'package:application_movies/models/models.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  final Movie movie;
  
  const CustomAppBar({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only( bottom: 10, left: 10, right: 10 ),
          color: Colors.black12,
          width: double.infinity,
          child:  Text(
            movie.title,
            style: const TextStyle( fontSize: 16 ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage( movie.getBackdropPath ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
