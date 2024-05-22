import 'package:convey/src/bot_model.dart';

class MessageModel {

  const MessageModel({
    required this.bot,
    required this.content,
  });

  final BotModel bot;
  final String content;

  Map<String, dynamic> toJson() {
    return {
      'bot': bot.toJson(),
      'content': content,
    };
  }

}
