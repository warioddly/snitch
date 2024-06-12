
import 'package:convey/src/models/bot_model.dart';
import 'package:convey/src/models/discord_user_model.dart';

class ConsoleMessageModel {


  const ConsoleMessageModel({
    required this.content,
    required this.createdAt,
    required this.bot,
    required this.user,
  });


  final BotModel bot;
  final DiscordUserModel user;
  final String content;
  final DateTime createdAt;


  factory ConsoleMessageModel.fromJson(Map<String, dynamic> data) {
    return ConsoleMessageModel(
        bot: BotModel.fromJson(data["bot"]),
        user: DiscordUserModel.fromJson(data["user"]),
        content: data["content"] ?? "",
        createdAt: data["createdAt"] != null ? DateTime.parse(data["createdAt"]) : DateTime.now()
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "bot": bot.toJson(),
      "user": user.toJson(),
      "content": content,
      "createdAt": createdAt.toIso8601String(),
    };
  }


}