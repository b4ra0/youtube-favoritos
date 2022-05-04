import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          const Align(
            child: Text(
              '0',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            alignment: Alignment.center,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index){
                return VideoTile(snapshot.data![index]);
              },
            );
          } else{
            return Container();
          }
        },
      ),
    );
  }
}
