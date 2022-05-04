import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/api.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  Api api = Api();
  api.search("casimiro");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
      ],
      dependencies: [],
      child: MaterialApp(
        title: 'Youtube Favoritos',
        home: HomeScreen(),
      ),
    );
  }
}