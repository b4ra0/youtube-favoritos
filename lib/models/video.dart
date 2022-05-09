class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;
  final String description;

  Video(
      {required this.id,
      required this.title,
      required this.thumb,
      required this.channel,
      required this.description});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return Video(
        id: json['id']['videoId'],
        description: json['snippet']['description'],
        title: json['snippet']['title'],
        thumb: json['snippet']['thumbnails']['high']['url'],
        channel: json['snippet']['channelTitle'],
      );
    } else {
      return Video(
        description: json['description'],
        id: json['videoId'],
        title: json['title'],
        thumb: json['thumb'],
        channel: json['channel'],
      );
    }
  }

  Map<String, dynamic> tojson() {
    return {
      'description': description,
      'videoId': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
    };
  }
}
