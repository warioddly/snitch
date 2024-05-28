import 'package:discord/discord.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/shared/model/base_model_interface.dart';

class ConsoleMessageModel extends IBaseModel {

  const ConsoleMessageModel({
    super.id,
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
        id: data["id"],
        bot: BotModel.fromJson(data["bot"]),
        user: DiscordUserModel.fromJson(data["user"]),
        content: data["content"] ?? "",
        createdAt: data["createdAt"] != null ? DateTime.parse(data["createdAt"]) : DateTime.now()
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null)
        "id": id,
      "bot": bot.toJson(),
      "user": user.toJson(),
      "content": content,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, bot, user, content, createdAt];


}