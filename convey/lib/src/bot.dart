import 'dart:convert';
import 'package:convey/core/constants/constants.dart';
import 'package:convey/src/models/bot_model.dart';
import 'package:convey/src/bot_config.dart';
import 'package:convey/src/models/console_message_model.dart';
import 'package:convey/src/runner.dart';
import 'package:nyxx/nyxx.dart';


class Bot {

  Bot({required this.config});


  final Cmd cmd = Cmd();
  final BotConfig config;
  late final NyxxGateway client;
  late final Guild guild;
  late final GuildTextChannel channel;
  late final User user;


  void start() async {

    client = await Nyxx.connectGateway(config.bot.token, GatewayIntents.all);
    user   = await client.users.fetchCurrentUser();

    client.onReady.listen((event) async {

      await _getChannel();

      print('Bot is ready to receive messages! 🚀');

      client.onMessageCreate.listen(_onMessage);

    });

  }


  Future<void> _onMessage(MessageCreateEvent event) async {

    final message = event.message;

    try {

      print('Message received: ${message.content}');

      if (event.message.author.id == user.id) {
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


  Future<void> _sendMessage(String content, [Message? message, bool reply = false]) async {
    try {



      if (content.length >= MAX_MESSAGE_LENGTH) {

        // Split the message into multiple messages with a maximum of 2000 characters each
        final messages = <String>[];

        for (var i = 0; i < content.length; i += MAX_MESSAGE_LENGTH) {
          content = content.substring(i, i + MAX_MESSAGE_LENGTH > content.length ? content.length : i + MAX_MESSAGE_LENGTH);
          messages.add(content);
          i = 0;
          print("messages[i].length part ${content}");
          print("messages[i].length ${messages[i].length}");
        }


        for (final content in messages) {
          await channel.sendMessage(MessageBuilder(
            content: _buildMessage(content),
            replyId: reply ? null : message?.id,
          ));
        }

        return;
      }

      await channel.sendMessage(MessageBuilder(
        content: _buildMessage(content),
        replyId: reply ? null : message?.id,
      ));

    }
    catch (e) {
      print('Error sending message: $e');
      await channel.sendMessage(MessageBuilder(
        content: _buildMessage('Error sending message: $e'),
        replyId: reply ? null : message?.id,
      ));
    }
  }


  Future<void> _getChannel() async {
    guild = await client.guilds.fetch(Snowflake(config.guildId));

    client.channels.cache.forEach((Snowflake id, Channel channel) async {
      if (channel is GuildTextChannel) {
        print('Bot is connected to channel: ${channel.name}');
        this.channel = channel;
        _sendMessage('!ping');
      }
    });
  }


  String _buildMessage(String content) {
    return jsonEncode({
      'bot': bot.toJson(),
      'user': {
        'id': user.id.value,
        'name': user.username,
        'avatar': user.avatar.url.toString()
      },
      'content': content,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }


  void stop() {
    client.close();
    print('Bot is stopping... 🛑');
  }


  BotModel get bot => config.bot;

}