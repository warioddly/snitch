import 'dart:convert';
import 'package:convey/core/constants/constants.dart';
import 'package:convey/src/models/bot_model.dart';
import 'package:convey/src/bot_config.dart';
import 'package:convey/src/models/console_message_model.dart';
import 'package:convey/src/runner.dart';
import 'package:discord/discord.dart';


class Bot {

  Bot({required this.config});


  final Cmd cmd = Cmd();
  final BotConfig config;
  late final Discord discord;


  void start() async {

    discord = Discord(
        token: config.bot.token,
        guildId: config.guildId,
        onMessageCreate: _onMessage,
        // onReady: (ReadyEvent event) async {
        //   print('Bot is ready to receive messages! 🚀');
        // },
        onChannelReady: (channel) async {
          print('Bot is connected to channel: ${channel.name}');
          _sendMessage('!ping');
        },
    );

    discord.start();

  }


  Future<void> _onMessage(MessageCreateEvent event) async {

    final message = event.message;

    try {

      print('Message received: ${message.content}');

      if (event.message.author.id.value == discord.user?.id) {
        return;
      }
      else if (message.content.isEmpty) {
        _sendMessage('Please send a text message', message);
        return;
      }

      final consoleMessage = ConsoleMessageModel.fromJson(jsonDecode(message.content));

      if (consoleMessage.content.trim() == '!config') {
        _sendMessage(jsonEncode(config.toJson()), message);
        return;
      }

      final result = await cmd.run(consoleMessage.content);
      _sendMessage(result.first.stdout, message);

    } catch (e) {
      _sendMessage(e.toString(), message);
    }

  }


  Future<void> _sendMessage(String content, [Message? message]) async {
    try {

      if (content.length >= MAX_MESSAGE_LENGTH) {

        // Split the message into multiple messages with a maximum of 2000 characters each
        final messages = <String>[];

        for (var i = 0; i < content.length; i += MAX_MESSAGE_LENGTH) {
          content = content.substring(i, i + MAX_MESSAGE_LENGTH > content.length ? content.length : i + MAX_MESSAGE_LENGTH);
          messages.add(content);
          i = 0;
          print("messages[i].length part $content");
          print("messages[i].length ${messages[i].length}");
        }


        for (final content in messages) {
          await discord.sendMessage(_buildMessage(content));
        }

        return;
      }

      await discord.sendMessage(_buildMessage(content));

    }
    catch (e) {
      print('Error sending message: $e');
      await discord.sendMessage(_buildMessage('Error sending message: $e'));
    }
  }


  String _buildMessage(String content) {
    return jsonEncode({
      'bot': bot.toJson(),
      'user': discord.user?.toJson(),
      'content': content,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }


  BotModel get bot => config.bot;

}