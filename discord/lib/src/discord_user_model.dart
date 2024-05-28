import 'package:nyxx/nyxx.dart';


class DiscordUserModel {


  const DiscordUserModel({
    required this.id,
    required this.name,
    required this.avatar,
  });


  final int id;
  final String name;
  final String avatar;


  factory DiscordUserModel.fromUser(User user) {
    return DiscordUserModel(
        id: user.id.value,
        name: user.username,
        avatar: user.avatar.url.path
    );
  }


  factory DiscordUserModel.fromJson(Map<String, dynamic> data) {
    return DiscordUserModel(
        id: data['id'],
        name: data['name'],
        avatar: data['avatar'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

}