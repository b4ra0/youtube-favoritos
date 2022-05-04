import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star_border,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
