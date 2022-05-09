import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:favoritos_youtube/screens/player_screen.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: bloc.outFav,
        initialData: const {},
        builder: (context, snapshot) {
          Map<String, Video> videos = snapshot.data as Map<String, Video>;
          return ListView(
            children: videos.values.map((e) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (DismissDirection direction) => bloc.toggleFavorite(e),
                key: ValueKey<int>(videos.length),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PlayerScreen(e)));
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(e);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(e.thumb),
                      ),
                      Expanded(
                        child: Text(
                          e.title,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
