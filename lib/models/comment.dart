import 'package:hacki/extensions/extensions.dart';
import 'package:hacki/models/item.dart';

class Comment extends Item {
  Comment({
    required int id,
    required int time,
    required int parent,
    required String by,
    required String text,
    required List<int> kids,
    required bool deleted,
  }) : super(
          id: id,
          time: time,
          by: by,
          text: text,
          kids: kids,
          parent: parent,
          deleted: deleted,
          score: 0,
          descendants: 0,
          dead: false,
          parts: [],
          poll: 0,
          title: '',
          url: '',
        );

  Comment.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] as int,
          time: json['time'] as int,
          by: json['by'] == null ? '' : json['by'] as String,
          text: json['text'] == null ? '' : json['text'] as String,
          kids: json['kids'] == null ? [] : (json['kids'] as List).cast<int>(),
          parent: json['parent'] as int,
          deleted: json['deleted'] == null ? false : json['deleted'] as bool,
          score: 0,
          descendants: 0,
          dead: false,
          parts: [],
          poll: 0,
          title: '',
          url: '',
        );

  String get postedDate =>
      DateTime.fromMillisecondsSinceEpoch(time * 1000).toReadableString();
}