import 'package:flutter/material.dart';
import 'package:movie_list/models/person_entity.dart';

class ArtistScreen extends StatelessWidget {
  final PersonEntity personEntity;

  const ArtistScreen({Key? key, required this.personEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(personEntity.name),
      ),
    );
  }
}
