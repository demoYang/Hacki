import 'package:hacki/extensions/extensions.dart';
import 'package:hacki/models/item.dart';

enum StoryType {
  top,
  latest,
  ask,
  show,
  jobs,
}

class Story extends Item {
  Story({
    required int descendants,
    required int id,
    required int score,
    required int time,
    required String by,
    required String title,
    required String url,
    required List<int> kids,
  }) : super(
          id: id,
          score: score,
          descendants: descendants,
          time: time,
          by: by,
          title: title,
          url: url,
          kids: kids,
          dead: false,
          parts: [],
          deleted: false,
          parent: 0,
          poll: 0,
          text: '',
        );

  Story.fromJson(Map<String, dynamic> json)
      : super(
          descendants:
              json['descendants'] == null ? 0 : json['descendants'] as int,
          id: json['id'] as int,
          score: json['score'] as int,
          time: json['time'] as int,
          by: json['by'] as String,
          title: json['title'] as String,
          url: json['url'] == null ? '' : json['url'] as String,
          kids: json['kids'] == null ? [] : (json['kids'] as List).cast<int>(),
          dead: false,
          parts: [],
          deleted: false,
          parent: 0,
          poll: 0,
          text: '',
        );

  String get postedDate =>
      DateTime.fromMillisecondsSinceEpoch(time * 1000).toReadableString();
}