import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 130 ),
      ),
    );
  }
}