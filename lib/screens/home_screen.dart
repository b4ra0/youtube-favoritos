import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:favoritos_youtube/screens/favorites_screen.dart';
import 'package:favoritos_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = BlocProvider.getBloc<VideosBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/yt_logo.png',
          width: 100,
        ),
        actions: [
          Align(
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data!.length}");
                } else {
                  return const Text('0');
                }
              },
            ),
            alignment: Alignment.center,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()));
            },
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List videos = snapshot.data as List;
            return ListView.builder(
              itemCount: videos.length + 1,
              itemBuilder: (context, index) {
                if (index < videos.length) {
                  return VideoTile(snapshot.data[index]);
                } else {
                  return Center(
                    child: IconButton(
                      onPressed: () {
                        bloc.inSearch.add(
                            "");
                      },
                      icon: const Icon(
                        Icons.expand_more,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
